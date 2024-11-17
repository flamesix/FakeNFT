//
//  DeleteNftRequest.swift
//  FakeNFT
//
//  Created by Pavel Bobkov on 17.11.2024.
//

import Foundation

struct DeleteNftRequest: NetworkRequest {
   var endpoint: URL? {
       URL(string: "\(RequestConstants.baseURL)/api/v1/currencies")
   }
    var httpMethod: HttpMethod = .put
    var dto: Dto?
}
