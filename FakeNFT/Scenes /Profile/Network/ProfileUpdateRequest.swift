//
//  ProfileUpdateRequest.swift
//  FakeNFT
//
//  Created by Soslan Dzampaev on 13.11.2024.
//

import Foundation

struct ProfileUpdateRequest: NetworkRequest {
    // MARK: - Properties
    var endpoint: URL? {
        return URL(string: "\(RequestConstants.baseURL)/api/v1/profile/1")
    }
    
    var httpMethod: HttpMethod {
        return .put
    }
    
    var dto: Dto?

    // MARK: - Init
    init(dto: Dto) {
        self.dto = dto
    }
}
