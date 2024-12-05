import Foundation

protocol StatisticsPresenterProtocol {
    var view: StatisticsViewControllerProtocol? { get set }
    var filteredUsers: [User] { get set }
    func viewDidLoad()
    func filter(by filter: FilterOption)
    func willDisplay(for indexPath: IndexPath)
}

enum StatisticState {
    case initial, loading, failed(Error), data([User])
}

final class StatisticsPresenter: StatisticsPresenterProtocol {
    
    weak var view: StatisticsViewControllerProtocol?
    
    private let service: StatisticsServiceProtocol
    
    private let filterStateStorage = FilterStateStorage.shared
    private let logginService = LoggingService.shared
    
    private var isLoadingPage: Bool = false
    private var hasMoreData: Bool = true
    private var page: Int = 0
    
    private var state = StatisticState.initial {
        didSet {
            stateDidChanged()
        }
    }
    
    private var users: [User] = [] {
        didSet {
            applyCurrentFilter()
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
            logginService.logCriticalError("can't move to initial state")
        case .loading:
            view?.showLoading()
            loadUsers()
        case .data(let users):
            handleNewData(users)
        case .failed(let error):
            handleLoadingError(error)
        }
    }
    
    private func handleNewData(_ users: [User]) {
        view?.hideLoading()
        if users.isEmpty {
            hasMoreData = false
        } else {
            self.users.append(contentsOf: users)
            page += 1
        }
        isLoadingPage = false
        view?.updateTableView()
    }
    
    private func handleLoadingError(_ error: Error) {
        let errorModel = makeErrorModel(error)
        view?.hideLoading()
        view?.showError(errorModel)
        isLoadingPage = false
    }
    
    private func loadUsers() {
        guard !isLoadingPage else { return }
        isLoadingPage = true
        service.loadUsers(page: page) { [weak self] result in
            switch result {
            case .success(let users):
                self?.state = .data(users)
            case .failure(let error):
                self?.state = .failed(error)
            }
        }
    }
    
    func willDisplay(for indexPath: IndexPath) {
        guard indexPath.row == filteredUsers.count - 1, hasMoreData else { return }
        state = .loading
    }
    
    func filter(by filter: FilterOption) {
        filterStateStorage.filterOption = filter
        applyCurrentFilter()
    }

    private func applyCurrentFilter() {
        filteredUsers = sortedUsers(for: filterStateStorage.filterOption ?? .rating)
    }

    private func sortedUsers(for filter: FilterOption) -> [User] {
        switch filter {
        case .name:
            return users.sorted { $0.name > $1.name }
        case .rating:
            return users.sorted { $0.rating < $1.rating }
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
