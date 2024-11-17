//
//  PaymentService.swift
//  FakeNFT
//
//  Created by Pavel Bobkov on 16.11.2024.
//

typealias PaymentCompletion = (Result<[Currency], Error>) -> Void

protocol PaymentServiceProtocol {
    func loadCurrencies(completion: @escaping PaymentCompletion)
}

final class PaymentService: PaymentServiceProtocol {
    private let networkClient: NetworkClient

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    func loadCurrencies(completion: @escaping PaymentCompletion) {
        let request = CurrenciesRequest()
        networkClient.send(request: request, type: [Currency].self) { result in
            switch result {
            case .success(let currencies):
                completion(.success(currencies))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
