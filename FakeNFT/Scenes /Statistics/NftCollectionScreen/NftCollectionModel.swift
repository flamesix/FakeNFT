import Foundation

protocol NftCollectionModelProtocol: AnyObject {
    func getNftCount() -> Int
    func getNft(_ indexRow: Int) -> Nft
}

final class NftCollectionModel: NftCollectionModelProtocol {

    weak var presenter: NftCollectionPresenterProtocol?

    private var nftService: NftServiceProtocol

    private var nfts: [Nft] = []

    init(nftService: NftServiceProtocol) {
        self.nftService = nftService
    }

    func getNftCount() -> Int {
        nfts.count
    }

    func getNft(_ indexRow: Int) -> Nft {
        nfts[indexRow]
    }
}
