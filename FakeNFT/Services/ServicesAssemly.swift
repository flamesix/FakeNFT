final class ServicesAssembly {

    private let networkClient: NetworkClient
    private let nftStorage: NftStorage
    private let nftCollectionCatalogueStorage: NftCollectionCatalogueStorage

    init(
        networkClient: NetworkClient,
        nftStorage: NftStorage,
        nftCollectionCatalogueStorage: NftCollectionCatalogueStorage
    ) {
        self.networkClient = networkClient
        self.nftStorage = nftStorage
        self.nftCollectionCatalogueStorage = nftCollectionCatalogueStorage
    }

    var nftService: NftService {
        NftServiceImpl(
            networkClient: networkClient,
            storage: nftStorage
        )
    }
    
    var nftCollectionCataloguService: NftCollectionCatalogueService {
        NftCollectionCatalogueServiceImpl(
            networkClient: networkClient,
            storage: nftCollectionCatalogueStorage
        )
    }
    
}
