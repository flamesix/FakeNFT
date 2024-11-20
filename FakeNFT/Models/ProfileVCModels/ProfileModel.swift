//
//  ProfileModel.swift
//  FakeNFT
//
//  Created by Soslan Dzampaev on 14.11.2024.
//

import Foundation

struct Profile: Codable {
    let name: String?
    let avatar: String?
    let description: String?
    let website: String?
    let nfts: [String]?
    let likes: [String]?
    let id: String?
}

struct ProfileUpdateDto: Dto {
    let name: String?
    let description: String?
    let website: String?

    func asDictionary() -> [String: String] {
        var dict: [String: String] = [:]
        
        if let name = name {
            dict["name"] = name
        }
        if let description = description {
            dict["description"] = description
        }
        if let website = website {
            dict["website"] = website
        }
        
        return dict
    }
}
