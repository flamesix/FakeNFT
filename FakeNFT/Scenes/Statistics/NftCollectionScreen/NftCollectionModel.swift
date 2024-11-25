import Foundation

protocol NftCollectionModelProtocol: AnyObject {
    func getNftCount() -> Int
    func getNft(_ indexRow: Int) -> Nft
    func loadNfts()
    func loadLikes()
    func isLiked(_ indexRow: Int) -> Bool
    func loadOrder()
    func isOrdered(_ indexRow: Int) -> Bool
    func tapLike(_ id: String, _ indexPath: IndexPath)
    func tapCart(_ id: String, _ indexPath: IndexPath)
}

final class NftCollectionModel: NftCollectionModelProtocol {
    
    weak var presenter: NftCollectionPresenterProtocol?
    private let nftService: NftServiceProtocol
    private let nftLikesService: NftLikesServiceProtocol
    private let nftOrderService: NftOrderServiceProtocol
    
    private var nfts: [Nft] = []
    private var likes: [String] = []
    private var order: [String] = []
    private var id: String = ""
    
    private var isNftsLoaded: Bool = false {
        didSet {
            isLoadingComplpeted()
        }
    }
    private var isLikesLoaded: Bool = false {
        didSet {
            isLoadingComplpeted()
        }
    }
    private var isOrderLoaded: Bool = false {
        didSet {
            isLoadingComplpeted()
        }
    }
    
    private let nftCollection: [String]
    
    // MARK: - Init
    init(nftService: NftServiceProtocol,
         nftLikesService: NftLikesServiceProtocol,
         nftOrderService: NftOrderServiceProtocol,
         nftCollection: [String])
    {
        self.nftService = nftService
        self.nftLikesService = nftLikesService
        self.nftOrderService = nftOrderService
        self.nftCollection = nftCollection
    }
    
    // MARK: - Methods
    func getNftCount() -> Int {
        nfts.count
    }
    
    func getNft(_ indexRow: Int) -> Nft {
        nfts[indexRow]
    }
    
    func loadNfts() {
        presenter?.state = .loading
        
        for id in nftCollection {
            nftService.loadNft(id: id) { [weak self] result in
                switch result {
                case .success(let nft):
                    self?.nfts.append(nft)
                    self?.isNftsLoaded = true
                case .failure(let error):
                    self?.presenter?.state = .failed(error)
                }
            }
        }
    }
    
    func loadLikes() {
        presenter?.state = .loading
        
        nftLikesService.loadNftLikes { [weak self] result in
            switch result {
            case .success(let likes):
                self?.likes = likes.likes
                self?.isLikesLoaded = true
            case .failure(let error):
                self?.presenter?.state = .failed(error)
            }
        }
    }
    
    func isLiked(_ indexRow: Int) -> Bool {
        likes.contains(nfts[indexRow].id)
    }
    
    func loadOrder() {
        presenter?.state = .loading
        
        nftOrderService.loadOrder { [weak self] result in
            switch result {
            case .success(let order):
                self?.order = order.nfts
                self?.id = order.id
                self?.isOrderLoaded = true
            case .failure(let error):
                self?.presenter?.state = .failed(error)
            }
        }
    }
    
    func isOrdered(_ indexRow: Int) -> Bool {
        order.contains(nfts[indexRow].id)
    }
    
    func tapLike(_ id: String, _ indexPath: IndexPath) {
        var likesCopy = likes
        if let index = likesCopy.firstIndex(of: id) {
            likesCopy.remove(at: index)
        } else {
            likesCopy.append(id)
        }
        
        nftLikesService.putLikes(id: likesCopy) { [weak self] result in
            switch result {
            case .success(_):
                self?.likes = likesCopy
            case .failure(let error):
                self?.presenter?.state = .failed(error)
            }
        }
    }

    func tapCart(_ id: String, _ indexPath: IndexPath) {
        var orderCopy = order
        if let index = orderCopy.firstIndex(of: id) {
            orderCopy.remove(at: index)
        } else {
            orderCopy.append(id)
        }
        
        nftOrderService.sendOrderPutRequest(nfts: orderCopy) { [weak self] result in
            switch result {
            case .success(_):
                self?.order = orderCopy
            case .failure(let error):
                self?.presenter?.state = .failed(error)
            }
        }
    }
    
    private func isLoadingComplpeted() {
        if isNftsLoaded && isLikesLoaded && isOrderLoaded {
            presenter?.state = .success
        } else {
            presenter?.state = .loading
        }
    }
}
