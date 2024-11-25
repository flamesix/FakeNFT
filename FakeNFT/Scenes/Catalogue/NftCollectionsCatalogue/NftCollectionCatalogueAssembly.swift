import UIKit

final class NftCollectionCatalogueAssembly {

    private let servicesAssembler: ServicesAssembly

    init(catalogueServicesAssembler: ServicesAssembly) {
        self.servicesAssembler = catalogueServicesAssembler
    }

    func build() -> UIViewController {
        let presenter = NftCollectionCataloguePresenter(service: servicesAssembler.nftCollectionCataloguService )
        let viewController = NftCollectionsCatalgueViewContoller(presenter: presenter, serviceAsssembly: servicesAssembler)
        presenter.view = viewController
        return viewController
    }
}
