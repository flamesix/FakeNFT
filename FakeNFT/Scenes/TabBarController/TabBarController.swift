import UIKit

final class TabBarController: UITabBarController {

    var servicesAssembly: ServicesAssembly!

    private let catalogTabBarItem = UITabBarItem(
        title: NSLocalizedString("Tab.catalog", comment: ""),
        image: UIImage(resource: .nftCatalogueTabBarItem),
        tag: 0
    )

    override func viewDidLoad() {
        super.viewDidLoad()

//        let catalogController = TestCatalogViewController(
//            servicesAssembly: servicesAssembly
//        )
        
//        let nftCollectionCatalogueAssembly = NftCollectionCatalogueAssembly(servicesAssembler: servicesAssembly)
//        
//        let preseter = NftCollectionCataloguePresenter(service: servicesAssembly.nftCollectionCataloguService)
//        let catalogController = NftCollectionsCatalgueViewContoller(presenter: preseter)
//        preseter.view = catalogController
//        let catalogController = NftMainCollectionController(servicesAssembly: servicesAssembly)
        
        let assembly = NftCollectionCatalogueAssembly(servicesAssembler: servicesAssembly)
        let catalogController = assembly.build()
        
        catalogController.tabBarItem = catalogTabBarItem

        viewControllers = [catalogController]

        view.backgroundColor = .systemBackground
    }
}
