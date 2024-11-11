import Foundation
import Kingfisher

// MARK: - Protocol

protocol NftCatalogueDetailPresenter {
    func viewDidLoad()
}

// MARK: - State

enum NftCatalogueDetailState {
    case initial, loading, failed(Error), data([NftCatalogueCollection])
}

final class NftCollectionCataloguePresenter: NftCatalogueDetailPresenter {

    // MARK: - Properties

    weak var view: NftCollectionsCatalgueViewContollerProtocol?
    private let service: NftCollectionCatalogueService
    private var state = NftCatalogueDetailState.initial {
        didSet {
            stateDidChanged()
        }
    }
    
    private var page = 0

    // MARK: - Init

    init(service: NftCollectionCatalogueService) {
        self.service = service
    }

    // MARK: - Functions

    func viewDidLoad() {
        state = .loading
    }

    private func stateDidChanged() {
        switch state {
        case .initial:
            assertionFailure("can't move to initial state")
        case .loading:
            view?.showLoading()
            loadNftCollectionCatalogue(page: page)
        case .data(let nftCatalogue):
            if nftCatalogue.count == (page + 1) * 5 {
                page += 1
            }
            view?.hideLoading()
            view?.displayCatalogue(nftCatalogue)
            
        case .failed(let error):
            let errorModel = makeErrorModel(error)
            view?.hideLoading()
            view?.showError(errorModel)
        }
    }

    private func loadNftCollectionCatalogue(page: Int) {
        service.loadNftCatalogue(page: page) { [weak self] result in
            switch result {
            case .success(let nftCatalogue):
                self?.state = .data(nftCatalogue)
            case .failure(let error):
                self?.state = .failed(error)
            }
        }
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
