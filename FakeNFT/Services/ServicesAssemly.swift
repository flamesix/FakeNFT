final class ServicesAssembly {

    private let networkClient: NetworkClient
    private let nftStorage: NftStorage

    init(
        networkClient: NetworkClient,
        nftStorage: NftStorage
    ) {
        self.networkClient = networkClient
        self.nftStorage = nftStorage
    }

    var nftService: NftServiceProtocol {
        NftService(
            networkClient: networkClient,
            storage: nftStorage
        )
    }
    
    var statisticService: StatisticsServiceProtocol {
        StatisticService(networkClient: networkClient)
    }
    
    var nftLikesService: NftLikesService {
        NftLikesServiceImpl(networkClient: networkClient)
    }
    
    var nftOrderPutService: NftOrderServiceProtocol {
        NftOrderService(networkClient: networkClient)
    }
}
