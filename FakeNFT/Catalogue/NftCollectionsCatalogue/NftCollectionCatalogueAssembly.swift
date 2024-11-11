import UIKit

public final class NftCollectionCatalogueAssembly {

    private let servicesAssembler: ServicesAssembly

    init(servicesAssembler: ServicesAssembly) {
        self.servicesAssembler = servicesAssembler
    }

    public func build() -> UIViewController {
        let presenter = NftCollectionCataloguePresenter(service: servicesAssembler.nftCollectionCataloguService )
        let viewController = NftCollectionsCatalgueViewContoller(presenter: presenter)
        presenter.view = viewController
        return viewController
    }
}
