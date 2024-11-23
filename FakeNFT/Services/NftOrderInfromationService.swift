import Foundation

typealias NftOrderCompletion = (Result<NftOrder, Error>) -> Void
typealias NftOrderPutCompletion = (Result<OrderPutResponse, Error>) -> Void

protocol NftOrderServiceProtocol {
    func loadNftOrder(completion: @escaping NftOrderCompletion)
    
    func sendOrderPutRequest(
        nfts: [String],
        completion: @escaping NftOrderPutCompletion
    )
}

final class NftOrderService: NftOrderServiceProtocol {

    private let networkClient: NetworkClient

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func loadNftOrder(completion: @escaping NftOrderCompletion) {

        let request = NftOrderRequest()
        networkClient.send(request: request, type: NftOrder.self) {result in
            switch result {
            case .success(let nftOrder):
                completion(.success(nftOrder))
            case .failure(let error):
                completion(.failure(error))
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
