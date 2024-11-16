//
//  PaymentService.swift
//  FakeNFT
//
//  Created by Pavel Bobkov on 16.11.2024.
//

protocol PaymentServiceProtocol {
   
}

final class PaymentService: PaymentServiceProtocol {
    private let networkClient: NetworkClient

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

//    func loadCart(completion: @escaping CartCompletion) {
//        let request = CartRequest()
//        networkClient.send(request: request, type: Cart.self) { result in
//            switch result {
//            case .success(let cart):
//                completion(.success(cart))
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }
}
