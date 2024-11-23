import Foundation

typealias NftOrderCompletion = (Result<Order, Error>) -> Void
typealias NftOrderPutCompletion = (Result<OrderPutResponse, Error>) -> Void

protocol NftOrderServiceProtocol {
    func sendOrderPutRequest(
        nfts: [String],
        completion: @escaping NftOrderPutCompletion
    )
    func loadOrder(completion: @escaping NftOrderCompletion)
}

final class NftOrderService: NftOrderServiceProtocol {
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func loadOrder(completion: @escaping NftOrderCompletion) {
        let request = OrdersGetRequest()
        
        networkClient.send(request: request, type: Order.self) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let order):
                    completion(.success(order))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func sendOrderPutRequest(
        nfts: [String],
        completion: @escaping NftOrderPutCompletion
    ) {
        let dto = NftOrderDtoObject(nfts: nfts)
        let request = NftOrderPutRequest(dto: dto)
        networkClient.send(request: request, type: OrderPutResponse.self) { result in
            switch result {
            case .success(let putResponse):
                completion(.success(putResponse))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
