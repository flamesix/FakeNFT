//
//  DeleteNftAssembly.swift
//  FakeNFT
//
//  Created by Pavel Bobkov on 17.11.2024.
//

import UIKit

public final class DeleteNftAssembly {

    private let servicesAssembler = ServicesAssembly(
        networkClient: DefaultNetworkClient(),
        nftStorage: NftStorageImpl()
    )

    func build(nft: Nft) -> UIViewController {
        let presenter = DeleteNftPresenter(
            nft: nft
        )
        let viewController = DeleteNftViewController(presenter: presenter)
        presenter.view = viewController
        return viewController
    }
}
