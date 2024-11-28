//
//  FavouriteNftModel.swift
//  FakeNFT
//
//  Created by Soslan Dzampaev on 23.11.2024.
//

import Foundation

struct FavouriteNftModel: Codable {
    let createdAt: String
    let name: String
    let images: [String]
    let rating: Int
    let description: String
    let price: Double
    let author: String
    let id: String
}
