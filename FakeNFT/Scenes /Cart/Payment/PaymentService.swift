//
//  PaymentService.swift
//  FakeNFT
//
//  Created by Pavel Bobkov on 16.11.2024.
//

typealias CurrenciesCompletion = (Result<[Currency], Error>) -> Void
typealias PaymentCompletion = (Result<OrderPaymentResponse, Error>) -> Void

protocol PaymentServiceProtocol {
    func loadCurrencies(completion: @escaping CurrenciesCompletion)
    func payOrder(currency_id: String, completion: @escaping PaymentCompletion)
}

final class PaymentService: PaymentServiceProtocol {
    private let networkClient: NetworkClient

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    func loadCurrencies(completion: @escaping CurrenciesCompletion) {
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
    
    func payOrder(currency_id: String, completion: @escaping PaymentCompletion) {
        let request = OrderPaymentRequest(currency_id: currency_id)
        networkClient.send(request: request, type: OrderPaymentResponse.self) { result in
            switch result {
            case .success(let orderPaymentResponse):
                completion(.success(orderPaymentResponse))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
