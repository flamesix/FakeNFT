import Foundation

protocol NftCollectionModelProtocol: AnyObject {
    func getNftCount() -> Int
    func getNft(_ indexRow: Int) -> Nft
    func loadNfts()
    func loadLikes()
    func isLiked(_ indexRow: Int) -> Bool
}

final class NftCollectionModel: NftCollectionModelProtocol {
    
    weak var presenter: NftCollectionPresenterProtocol?
    private let nftService: NftServiceProtocol
    private let nftLikesService: NftLikesService
    private let nftOrderPutService: NftOrderPutService
    
    private var nfts: [Nft] = []
    private var likes: [String] = []
    
    private let nftCollection: [String]
    
    init(nftService: NftServiceProtocol,
         nftLikesService: NftLikesService,
         nftOrderPutService: NftOrderPutService,
         nftCollection: [String])
    {
        self.nftService = nftService
        self.nftLikesService = nftLikesService
        self.nftOrderPutService = nftOrderPutService
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
        
        likes.removeAll()
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
}
