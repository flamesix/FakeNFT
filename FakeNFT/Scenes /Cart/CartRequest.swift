//
//  CartRequest.swift
//  FakeNFT
//
//  Created by Pavel Bobkov on 13.11.2024.
//

import Foundation

struct CartRequest: NetworkRequest {
   var endpoint: URL? {
       URL(string: "\(RequestConstants.baseURL)/api/v1/orders/1")
   }
    var httpMethod: HttpMethod = .get
    var dto: Dto?
}
