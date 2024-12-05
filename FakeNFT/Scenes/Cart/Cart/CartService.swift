//
//  CartService.swift
//  FakeNFT
//
//  Created by Pavel Bobkov on 13.11.2024.
//

typealias CartCompletion = (Result<Cart, Error>) -> Void

protocol CartServiceProtocol {
    func loadCart(completion: @escaping CartCompletion)
}

final class CartService: CartServiceProtocol {
    private let networkClient: NetworkClient

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    func loadCart(completion: @escaping CartCompletion) {
        let request = CartRequest()
        networkClient.send(request: request, type: Cart.self) { result in
            switch result {
            case .success(let cart):
                completion(.success(cart))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
