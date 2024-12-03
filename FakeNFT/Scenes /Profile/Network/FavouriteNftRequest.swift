//
//  FavouriteNFtRequest.swift
//  FakeNFT
//
//  Created by Soslan Dzampaev on 23.11.2024.
//

import Foundation

struct FavouriteNftRequest: NetworkRequest {
    let nftId: String

    var endpoint: URL? {
        return URL(string: "\(RequestConstants.baseURL)/api/v1/nft/\(nftId)")
    }

    var httpMethod: HttpMethod {
        return .get
    }

    var dto: Dto? {
        return nil
    }
}
