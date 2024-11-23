import UIKit

final class NftCollectionAssembly {
    
    private let servicesAssembler: ServicesAssembly

    init(servicesAssembler: ServicesAssembly) {
        self.servicesAssembler = servicesAssembler
    }

    func build() -> UIViewController {
        let nftModel = NftCollectionModel(nftService: servicesAssembler.nftService)
        let presenter = NftCollectionPresenter(nftModel: nftModel)
        let viewController = NftCollectionViewController(servicesAssembly: servicesAssembler)
        presenter.view = viewController
        viewController.presenter = presenter
        return viewController
    }
}
