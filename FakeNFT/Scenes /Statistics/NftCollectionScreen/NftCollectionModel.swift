import Foundation

protocol NftCollectionModelProtocol: AnyObject {
    func getNftCount() -> Int
    func getNft(_ indexRow: Int) -> Nft
    func loadNfts()
}

final class NftCollectionModel: NftCollectionModelProtocol {
    
    weak var presenter: NftCollectionPresenterProtocol?
    private var nftService: NftServiceProtocol
    
    private var nfts: [Nft] = []
    private let nftCollection: [String]
    
    init(nftService: NftServiceProtocol, nftCollection: [String]) {
        self.nftService = nftService
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
}
