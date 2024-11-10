//
//  NftCollectionCatalogueFactory.swift
//  FakeNFT
//
//  Created by Федор Завьялов on 10.11.2024.
//

import UIKit

final class NftCollectionCatalogueFactory {
    func prepareCatalogue() -> [NftCollectionModel] {
        return [
            NftCollectionModel(
                id: "1",
                name: "one",
                cover: UIImage(resource: ._01),
                nfts: ["1","2","3"],
                description: "",
                author: ""
            ),
            NftCollectionModel(
                id: "2",
                name: "two",
                cover: UIImage(resource: ._02),
                nfts: ["1","2","3","4"],
                description: "",
                author: ""
            ),
            NftCollectionModel(
                id: "3",
                name: "three",
                cover: UIImage(resource: ._03),
                nfts: ["1", "2", "3", "4", "5"],
                description: "",
                author: ""
            ),
            NftCollectionModel(
                id: "1",
                name: "one",
                cover: UIImage(resource: ._01),
                nfts: ["1","2","3"],
                description: "",
                author: ""
            ),
            NftCollectionModel(
                id: "2",
                name: "two",
                cover: UIImage(resource: ._02),
                nfts: ["1","2","3","4"],
                description: "",
                author: ""
            ),
            NftCollectionModel(
                id: "3",
                name: "three",
                cover: UIImage(resource: ._03),
                nfts: ["1", "2", "3", "4", "5"],
                description: "",
                author: ""
            )
        ]
    }
}
