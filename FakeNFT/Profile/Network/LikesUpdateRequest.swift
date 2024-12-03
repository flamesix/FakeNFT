//
//  LikesUpdateRequest.swift
//  FakeNFT
//
//  Created by Soslan Dzampaev on 23.11.2024.
//
import Foundation

struct LikesUpdateDto: Dto {
    let likes: [String]
    
    func asDictionary() -> [String: String] {
        return ["likes": likes.joined(separator: ",")]
    }
    
    func asDictionary() -> [String: Any] {
        return ["likes": likes.isEmpty ? [] : likes]
    }
}

struct LikesUpdateRequest: NetworkRequest {
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
