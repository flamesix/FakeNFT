import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    private let networkClient = DefaultNetworkClient()
    private lazy var catalogueServicesAssembly = CatalogueServicesAssembly(
        networkClient: networkClient,
        nftCollectionCatalogueStorage: NftCollectionCatalogueStorageImpl(),
        nftCollectionItemsStorage: NftCollectionItemsStorageImpl()
    )

    func scene(_: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        
        let tabBarController = window?.rootViewController as? TabBarController
        tabBarController?.catalogueServicesAssembly = catalogueServicesAssembly
    }
}
