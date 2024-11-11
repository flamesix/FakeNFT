import Foundation

protocol StatisticsPresenterProtocol {
    var view: StatisticsViewControllerProtocol? { get set }
    var filteredUsers: [User] { get set }
    func viewDidLoad()
    func filter(by filter: FilterOption)
}

enum StatisticState {
    case initial, loading, failed(Error), data([User])
}

final class StatisticsPresenter: StatisticsPresenterProtocol {
    
    weak var view: StatisticsViewControllerProtocol?
    
    private let service: StatisticsServiceProtocol
    
    private let filterStateStorage = FilterStateStorage.shared
    private var filterOption: FilterOption = .rating
    
    private var state = StatisticState.initial {
        didSet {
            stateDidChanged()
        }
    }
    
    private var users: [User] = [] {
        didSet {
            filter(by: filterStateStorage.filterOption ?? .rating)
        }
    }
    
    var filteredUsers: [User] = []
    
    init(service: StatisticsServiceProtocol) {
        self.service = service
    }
    
    func viewDidLoad() {
        state = .loading
        
    }
    
    func stateDidChanged() {
        switch state {
        case .initial:
            assertionFailure("can't move to initial state")
        case .loading:
            view?.showLoading()
            loadUsers()
        case .data(let users):
            view?.hideLoading()
            self.users = users
            view?.updateTableView()
        case .failed(let error):
            let errorModel = makeErrorModel(error)
            view?.hideLoading()
            view?.showError(errorModel)
        }
    }
    
    private func loadUsers() {
        service.loadUsers { [weak self] result in
            switch result {
            case .success(let users):
                self?.state = .data(users)
            case .failure(let error):
                self?.state = .failed(error)
            }
        }
    }
    
    func filter(by filter: FilterOption) {
        switch filter {
        case .name:
            filteredUsers = users.sorted { $0.name > $1.name }
            filterStateStorage.filterOption = .name
        case .rating:
            filteredUsers = users.sorted { Int($0.rating) ?? 0 > Int($1.rating) ?? 0 }
            filterStateStorage.filterOption = .rating
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
