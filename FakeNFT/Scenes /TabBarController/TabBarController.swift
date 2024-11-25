import UIKit

enum TabBarTags: Int {
    case catalog = 0
    case cart = 1
}

final class TabBarController: UITabBarController {
    
    var servicesAssembly: ServicesAssembly!
    
    private let catalogTabBarItem = UITabBarItem(
        title: NSLocalizedString("Tab.catalog", comment: ""),
        image: UIImage(systemName: "square.stack.3d.up.fill"),
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
        tag: 3
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let catalogController = TestCatalogViewController(
            servicesAssembly: servicesAssembly
        )
        catalogController.tabBarItem = catalogTabBarItem
        
        let cartAssembly = CartAssembly(servicesAssembler: servicesAssembly)
        let cartController = cartAssembly.build()
        cartController.tabBarItem = cartTabBarItem

        viewControllers = [catalogController, cartController]

        
        let assembly = StatisticsAssembly(servicesAssembler: servicesAssembly)
        let statisticsController = assembly.build()
        statisticsController.tabBarItem = statisticsTabBarItem
        
        viewControllers = [catalogController, statisticsController]
        
        view.backgroundColor = .systemBackground
        tabBar.unselectedItemTintColor = .nftBlack
    }
}
