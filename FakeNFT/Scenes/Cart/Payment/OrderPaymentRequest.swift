//
//  OrderPaymentRequest.swift
//  FakeNFT
//
//  Created by Pavel Bobkov on 22.11.2024.
//

import Foundation

struct OrderPaymentRequest: NetworkRequest {
    let currency_id: String
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/orders/1/payment/\(currency_id)")
    }
    var httpMethod: HttpMethod = .get
    var dto: Dto?
}
