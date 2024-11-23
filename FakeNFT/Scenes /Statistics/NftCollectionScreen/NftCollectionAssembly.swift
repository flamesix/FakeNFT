import UIKit

final class NftCollectionAssembly {
    
    private let servicesAssembler: ServicesAssembly

    init(servicesAssembler: ServicesAssembly) {
        self.servicesAssembler = servicesAssembler
    }

    func build(nftCollection: [String]) -> UIViewController {
        let nftModel = NftCollectionModel(nftService: servicesAssembler.nftService,
                                          nftLikesService: servicesAssembler.nftLikesService,
                                          nftOrderService: servicesAssembler.nftOrderPutService,
                                          nftCollection: nftCollection)
        let presenter = NftCollectionPresenter(nftModel: nftModel)
        let viewController = NftCollectionViewController(servicesAssembly: servicesAssembler)
        presenter.view = viewController
        nftModel.presenter = presenter
        viewController.presenter = presenter
        return viewController
    }
}
