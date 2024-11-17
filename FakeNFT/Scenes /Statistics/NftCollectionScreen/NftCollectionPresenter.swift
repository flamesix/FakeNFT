import Foundation

protocol NftCollectionPresenterProtocol {
    var view: NftCollectionViewControllerProtocol? { get set }
    var nfts: [Nft] { get set }
    func viewDidLoad()
}

final class NftCollectionPresenter: NftCollectionPresenterProtocol {
    
    weak var view: NftCollectionViewControllerProtocol?
    
    var nfts: [Nft] = []
    
    func viewDidLoad() {
        
    }
}
