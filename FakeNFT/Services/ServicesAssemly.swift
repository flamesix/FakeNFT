final class ServicesAssembly {

    private let networkClient: NetworkClient
    private let nftStorage: NftStorage
    private let nftCollectionCatalogueStorage: NftCollectionCatalogueStorage
    private let nftCollectionItemsStorage: NftCollectionItemsStorage

    init(
        networkClient: NetworkClient,
        nftStorage: NftStorage,
        nftCollectionCatalogueStorage: NftCollectionCatalogueStorage,
        nftCollectionItemsStorage: NftCollectionItemsStorage
    ) {
        self.networkClient = networkClient
        self.nftStorage = nftStorage
        self.nftCollectionCatalogueStorage = nftCollectionCatalogueStorage
        self.nftCollectionItemsStorage = nftCollectionItemsStorage
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
    
    var nftItemsService: NftItemsService {
        NftItemsServiceImpl(
            networkClient: networkClient,
            storage: nftCollectionItemsStorage
        )
    }
    
}
