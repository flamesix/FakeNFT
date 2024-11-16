//
//  NftCatalogueCollectionByldRequest.swift
//  FakeNFT
//
//  Created by Федор Завьялов on 10.11.2024.
//

import Foundation

struct NftCatalogueCollectionRequest: NetworkRequest {
    var page: Int
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/collections?page=\(page)&size=5")
    }
    var dto: Dto?
}
