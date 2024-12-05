//
//  NftCatalogueCollection.swift
//  FakeNFT
//
//  Created by Федор Завьялов on 10.11.2024.
//

import Foundation

struct Catalogue: Decodable {
    let createdAt: String
    let name: String
    let cover: URL
    let nfts: [String]
    let description: String
    let author: String
    let id: String
}
