//
//  Currency.swift
//  FakeNFT
//
//  Created by Pavel Bobkov on 17.11.2024.
//

import  Foundation

struct Currency: Decodable {
    let title: String
    let name: String
    let image: URL
    let id: String
}
