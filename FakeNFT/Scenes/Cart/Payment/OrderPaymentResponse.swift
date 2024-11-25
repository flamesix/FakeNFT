//
//  OrderPaymentResponse.swift
//  FakeNFT
//
//  Created by Pavel Bobkov on 22.11.2024.
//

struct OrderPaymentResponse: Codable {
    let success: Bool
    let orderId: String
    let id: String
}
