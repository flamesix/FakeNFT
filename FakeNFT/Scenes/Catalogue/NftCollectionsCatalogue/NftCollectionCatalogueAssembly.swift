import UIKit

public final class NftCollectionCatalogueAssembly {

    private let servicesAssembler: CatalogueServicesAssembly

    init(catalogueServicesAssembler: CatalogueServicesAssembly) {
        self.servicesAssembler = catalogueServicesAssembler
    }

    public func build() -> UIViewController {
        let presenter = NftCollectionCataloguePresenter(service: servicesAssembler.nftCollectionCataloguService )
        let viewController = NftCollectionsCatalgueViewContoller(presenter: presenter, serviceAsssembly: servicesAssembler)
        presenter.view = viewController
        return viewController
    }
}
