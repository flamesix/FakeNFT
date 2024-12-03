import UIKit

enum TabBarTags: Int {
    case catalog = 0
    case cart = 1
    case profile = 2
    case statistic = 3
}

final class TabBarController: UITabBarController {
    
    var servicesAssembly: ServicesAssembly
    
    private let profileTabBarItem = UITabBarItem(
        title: NSLocalizedString("Tab.profile", comment: ""),
        image: UIImage(named: "profileIcon"),
        tag: TabBarTags.profile.rawValue
    )
    
    private let catalogTabBarItem = UITabBarItem(
        title: NSLocalizedString("Tab.catalog", comment: ""),
        image: UIImage(resource: .nftCatalogueTabBarItem),
        tag: TabBarTags.catalog.rawValue
    )
    
    private let cartTabBarItem = UITabBarItem(
        title: NSLocalizedString("Tab.cart", comment: ""),
        image: UIImage(named: "cartIcon"),
        tag: TabBarTags.cart.rawValue
    )

    
    private let statisticsTabBarItem = UITabBarItem(
        title: NSLocalizedString("Tab.statistics", comment: ""),
        image: UIImage(systemName: "flag.2.crossed.fill"),
        tag: TabBarTags.statistic.rawValue
    )
    
    init(servicesAssembly: ServicesAssembly) {
        self.servicesAssembly = servicesAssembly
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let catalogueAssembly = NftCollectionCatalogueAssembly(catalogueServicesAssembler: servicesAssembly)
        let catalogController = catalogueAssembly.build()
        catalogController.tabBarItem = catalogTabBarItem
        
        let cartAssembly = CartAssembly(servicesAssembler: servicesAssembly)
        let cartController = cartAssembly.build()
        cartController.tabBarItem = cartTabBarItem
        
        let profileController = ProfileViewController()
        profileController.tabBarItem = profileTabBarItem
        let profileNavigationController = UINavigationController(rootViewController: profileController)
        
        let statisticsAssembly = StatisticsAssembly(servicesAssembler: servicesAssembly)
        let statisticsController = statisticsAssembly.build()
        statisticsController.tabBarItem = statisticsTabBarItem
        
        viewControllers = [profileNavigationController, catalogController, cartController, statisticsController]
        
        view.backgroundColor = .nftWhite
        tabBar.unselectedItemTintColor = .nftBlack
        tabBar.barTintColor = .nftWhite
        tabBar.isTranslucent = false
    }
}
