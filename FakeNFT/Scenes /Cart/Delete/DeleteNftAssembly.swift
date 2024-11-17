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

    func build(delegate: DeleteNftPresenterDelegate, deletedNft: Nft, allNft: [Nft]) -> UIViewController {
        let presenter = DeleteNftPresenter(
            delegate: delegate,
            service: servicesAssembler.deleteNftService,
            deletedNft: deletedNft,
            allNfts: allNft
        )
        let viewController = DeleteNftViewController(presenter: presenter)
        presenter.view = viewController
        return viewController
    }
}
