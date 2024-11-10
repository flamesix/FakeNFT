import Foundation

protocol StatisticsPresenterProtocol {
    var view: StatisticsViewControllerProtocol? { get set }
    var filteredUsers: [User] { get set }
    func viewDidLoad()
    func filter(by filter: FilterOption)
}

final class StatisticsPresenter: StatisticsPresenterProtocol {
    
    weak var view: StatisticsViewControllerProtocol?
    
    private let filterStateStorage = FilterStateStorage.shared
    private var filterOption: FilterOption = .rating
    
    private var users: [User] = [
        User(name: "User1", avatar: "", description: "", website: "", nfts: Array(repeating: "1", count: 3), rating: "1", id: "123"),
        User(name: "User2", avatar: "", description: "", website: "", nfts: Array(repeating: "1", count: 5), rating: "2", id: "125"),
        User(name: "User3", avatar: "", description: "", website: "", nfts: Array(repeating: "1", count: 9), rating: "3", id: "363"),
        User(name: "User4", avatar: "", description: "", website: "", nfts: Array(repeating: "1", count: 100), rating: "4", id: "742"),
        User(name: "User5", avatar: "", description: "", website: "", nfts: Array(repeating: "1", count: 25), rating: "5", id: "473"),
        User(name: "User6", avatar: "", description: "", website: "", nfts: Array(repeating: "1", count: 51), rating: "6", id: "190"),
        User(name: "User7", avatar: "", description: "", website: "", nfts: Array(repeating: "1", count: 87), rating: "7", id: "982"),
        User(name: "User8", avatar: "", description: "", website: "", nfts: Array(repeating: "1", count: 2), rating: "8", id: "865"),
        User(name: "User9", avatar: "", description: "", website: "", nfts: Array(repeating: "1", count: 3), rating: "9", id: "123"),
        User(name: "User10", avatar: "", description: "", website: "", nfts: Array(repeating: "1", count: 5), rating: "10", id: "125"),
        User(name: "User11", avatar: "", description: "", website: "", nfts: Array(repeating: "1", count: 9), rating: "11", id: "363"),
        User(name: "User12", avatar: "", description: "", website: "", nfts: Array(repeating: "1", count: 100), rating: "12", id: "742"),
        User(name: "User13", avatar: "", description: "", website: "", nfts: Array(repeating: "1", count: 25), rating: "13", id: "473"),
        User(name: "User14", avatar: "", description: "", website: "", nfts: Array(repeating: "1", count: 51), rating: "14", id: "190"),
        User(name: "User15", avatar: "", description: "", website: "", nfts: Array(repeating: "1", count: 87), rating: "15", id: "982"),
        User(name: "User16", avatar: "", description: "", website: "", nfts: Array(repeating: "1", count: 2), rating: "16", id: "865"),
    ]
    
    var filteredUsers: [User] = []
    
    func viewDidLoad() {
        filter(by: filterStateStorage.filterOption ?? .rating)
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
