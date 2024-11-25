final class ServicesAssembly {

    private let networkClient: NetworkClient
    private let nftStorage: NftStorage
    private let nftCollectionCatalogueStorage: NftCollectionCatalogueStorage
    private let nftCollectionItemsStorage: NftStorage

    init(
        networkClient: NetworkClient,
        nftStorage: NftStorage,
        nftCollectionCatalogueStorage: NftCollectionCatalogueStorage,
        nftCollectionItemsStorage: NftStorage
    ) {
        self.networkClient = networkClient
        self.nftStorage = nftStorage
        self.nftCollectionCatalogueStorage = nftCollectionCatalogueStorage
        self.nftCollectionItemsStorage = nftStorage
    }

    var nftService: NftServiceProtocol {
        NftService(
            networkClient: networkClient,
            storage: nftStorage
        )
    }
    
    var cartService: CartServiceProtocol {
        CartService(
            networkClient: networkClient
        )
    }
    
    var paymentService: PaymentServiceProtocol {
        PaymentService(
            networkClient: networkClient
        )
    }
    
    var deleteNftService: DeleteNftServiceProtocol {
        DeleteNftService(
            networkClient: networkClient
        )
    }
    
    var statisticService: StatisticsServiceProtocol {
        StatisticService(networkClient: networkClient)
    }
    
    var nftLikesService: NftLikesServiceProtocol {
        NftLikesService(networkClient: networkClient)
    }
    
    var nftOrderService: NftOrderServiceProtocol {
        NftOrderService(
            networkClient: networkClient
        )
    }
    
    var nftOrderPutService: NftOrderServiceProtocol {
        NftOrderService(networkClient: networkClient)
    }
    
    var nftCollectionCataloguService: NftCollectionCatalogueService {
        NftCollectionCatalogueServiceImpl(
            networkClient: networkClient,
            storage: nftCollectionCatalogueStorage
        )
    }
    
    var nftItemsService: NftServiceProtocol {
        NftService(
            networkClient: networkClient,
            storage: nftCollectionItemsStorage
        )
    }
    
//    var nftItemsService: NftServiceProtocol {
//        NftService(
//            networkClient: networkClient,
//            storage: nftCollectionItemsStorage
//        )
//    }
    
    var nftProfilePutService: NftProfilePutService {
        NftProfilePutServiceImpl(
            networkClient: networkClient
        )
    }
}
