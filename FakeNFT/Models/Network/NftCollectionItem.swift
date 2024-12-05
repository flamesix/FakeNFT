//
//  NftCollectionItem.swift
//  FakeNFT
//
//  Created by Федор Завьялов on 12.11.2024.
//

import Foundation

struct NftCollectionItem: Decodable {
    let name: String
    let images: [URL]
    let rating: Int
    let price: Float
    let id: String
}

