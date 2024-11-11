import Foundation

protocol StatisticsPresenterProtocol {
    var view: StatisticsViewControllerProtocol? { get set }
    var filteredUsers: [User] { get set }
    func viewDidLoad()
    func filter(by filter: FilterOption)
}

final class StatisticsPresenter: StatisticsPresenterProtocol {
    
    weak var view: StatisticsViewControllerProtocol?
    
    private let service: StatisticsServiceProtocol
    
    private let filterStateStorage = FilterStateStorage.shared
    private var filterOption: FilterOption = .rating
    
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
        service.loadUsers { [weak self] result in
            switch result {
            case .success(let users):
                self?.users = users
            case .failure(let error):
                break
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
}
