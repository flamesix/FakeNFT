import Foundation

protocol NftCollectionPresenterProtocol: AnyObject {
    var view: NftCollectionViewControllerProtocol? { get set }
    var state: NftCollectionState { get set }
    func viewDidLoad()
    func getNftCount() -> Int
    func getNft(_ indexRow: Int) -> Nft
}

enum NftCollectionState {
    case initial, loading, failed(Error), success
}

final class NftCollectionPresenter: NftCollectionPresenterProtocol {
    
    weak var view: NftCollectionViewControllerProtocol?
    
    private let nftModel: NftCollectionModelProtocol
    private let logginService = LoggingService.shared
    
    private var isLoading: Bool = false
    
    var state = NftCollectionState.initial {
        didSet {
            stateDidChanged()
        }
    }
    
    init(nftModel: NftCollectionModelProtocol) {
        self.nftModel = nftModel
    }
    
    func viewDidLoad() {
        nftModel.loadNfts()
        nftModel.loadLikes()
    }
    
    func getNftCount() -> Int {
        nftModel.getNftCount()
    }
    
    func getNft(_ indexRow: Int) -> Nft {
        nftModel.getNft(indexRow)
    }
    
    func isLiked(_ indexRow: Int) -> Bool {
        nftModel.isLiked(indexRow)
    }
    
    func stateDidChanged() {
        switch state {
        case .initial:
            logginService.logCriticalError("can't move to initial state")
        case .loading:
            view?.showLoading()
        case .success:
            view?.hideLoading()
            view?.updateCollectionView()
        case .failed(let error):
            handleLoadingError(error)
        }
    }
    
    private func handleLoadingError(_ error: Error) {
        let errorModel = makeErrorModel(error)
        view?.hideLoading()
        view?.showError(errorModel)
        isLoading = false
    }
    
    private func makeErrorModel(_ error: Error) -> ErrorModel {
        let message: String
        switch error {
        case is NetworkClientError:
            message = NSLocalizedString("Error.network", comment: "")
        default:
            message = NSLocalizedString("Error.unknown", comment: "")
        }
        
        let actionText = NSLocalizedString("Error.repeat", comment: "")
        return ErrorModel(message: message, actionText: actionText) { [weak self] in
            self?.state = .loading
        }
    }
}
