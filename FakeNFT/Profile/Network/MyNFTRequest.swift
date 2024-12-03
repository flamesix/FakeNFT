//
//  MyNFTRequest.swift
//  FakeNFT
//
//  Created by Soslan Dzampaev on 29.11.2024.
//

import Foundation

struct MyNFTRequest: NetworkRequest {

    var endpoint: URL? {
        return URL(string: "\(RequestConstants.baseURL)/api/v1/nft")
    }

    var httpMethod: HttpMethod {
        return .get
    }

    var dto: Dto? {
        return nil
    }
}
