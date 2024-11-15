import UIKit

final class TabBarController: UITabBarController {

    var catalogueServicesAssembly: CatalogueServicesAssembly!

    private let catalogTabBarItem = UITabBarItem(
        title: NSLocalizedString("Tab.catalog", comment: ""),
        image: UIImage(resource: .nftCatalogueTabBarItem),
        tag: 0
    )

    override func viewDidLoad() {
        super.viewDidLoad()

        let catalogueAssembly = NftCollectionCatalogueAssembly(catalogueServicesAssembler: catalogueServicesAssembly)
        let catalogController = catalogueAssembly.build()
        catalogController.tabBarItem = catalogTabBarItem

        viewControllers = [catalogController]

        view.backgroundColor = .systemBackground
    }
}
