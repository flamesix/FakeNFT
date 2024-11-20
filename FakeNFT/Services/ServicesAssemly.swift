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

    var nftService: NftService {
        NftServiceImpl(
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
}
