//
//  NftCatalogueCollectionByldRequest.swift
//  FakeNFT
//
//  Created by Федор Завьялов on 10.11.2024.
//

import Foundation

struct NftCatalogueCollectionByldRequest: NetworkRequest {
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/collections")
    }
    var dto: Dto?
}
