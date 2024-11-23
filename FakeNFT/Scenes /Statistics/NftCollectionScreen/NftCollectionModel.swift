import Foundation

protocol NftCollectionModelProtocol: AnyObject {
    func getNftCount() -> Int
    func getNft(_ indexRow: Int) -> Nft
    func loadNfts()
    func loadLikes()
    func isLiked(_ indexRow: Int) -> Bool
    func loadOrder()
    func isOrdered(_ indexRow: Int) -> Bool
}

final class NftCollectionModel: NftCollectionModelProtocol {
    
    weak var presenter: NftCollectionPresenterProtocol?
    private let nftService: NftServiceProtocol
    private let nftLikesService: NftLikesService
    private let nftOrderService: NftOrderServiceProtocol
    
    private var nfts: [Nft] = []
    private var likes: [String] = []
    private var order: [String] = []
    private var id: String = ""
    
    private let nftCollection: [String]
    
    init(nftService: NftServiceProtocol,
         nftLikesService: NftLikesService,
         nftOrderService: NftOrderServiceProtocol,
         nftCollection: [String])
    {
        self.nftService = nftService
        self.nftLikesService = nftLikesService
        self.nftOrderService = nftOrderService
        self.nftCollection = nftCollection
    }
    
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
                    self?.presenter?.state = .success
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
                self?.presenter?.state = .success
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
                self?.presenter?.state = .success
            case .failure(let error):
                self?.presenter?.state = .failed(error)
            }
        }
    }
    
    func isOrdered(_ indexRow: Int) -> Bool {
        order.contains(nfts[indexRow].id)
    }
}
