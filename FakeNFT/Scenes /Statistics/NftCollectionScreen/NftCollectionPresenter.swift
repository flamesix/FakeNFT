import Foundation

protocol NftCollectionPresenterProtocol: AnyObject {
    var view: NftCollectionViewControllerProtocol? { get set }
    func viewDidLoad()
    func getNftCount() -> Int
    func getNft(_ indexRow: Int) -> Nft
}

enum NftCollectionState {
    case initial, loading, failed(Error), data([User])
}

final class NftCollectionPresenter: NftCollectionPresenterProtocol {
    
    weak var view: NftCollectionViewControllerProtocol?
    
    private let nftModel: NftCollectionModelProtocol
    
    private var state = NftCollectionState.initial {
        didSet {
            stateDidChanged()
        }
    }
    
    init(nftModel: NftCollectionModelProtocol) {
        self.nftModel = nftModel
    }
    
    func viewDidLoad() {
        
    }
    
    func getNftCount() -> Int {
        nftModel.getNftCount()
    }
    
    func getNft(_ indexRow: Int) -> Nft {
        nftModel.getNft(indexRow)
    }
    
    func stateDidChanged() {
        switch state {
        case .initial:
//            logginService.logCriticalError("can't move to initial state")
            break
        case .loading:
            view?.showLoading()
//            loadUsers()
        case .data(let users):
            break
        case .failed(let error):
            break
        }
    }
}
