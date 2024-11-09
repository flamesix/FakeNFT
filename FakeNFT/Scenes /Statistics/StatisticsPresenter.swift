import Foundation

protocol StatisticsPresenterProtocol {
    var view: StatisticsViewControllerProtocol? { get set }
    var filteresUsers: [User] { get set }
    func viewDidLoad()
    func filter(by filter: FilterOption)
}

enum FilterOption {
    case name
    case rating
}

final class StatisticsPresenter: StatisticsPresenterProtocol {
    
    weak var view: StatisticsViewControllerProtocol?
    
    private var users: [User] = [
        User(name: "User1", avatar: "", description: "", website: "", nfts: Array(repeating: "1", count: 3), rating: "1", id: "123"),
        User(name: "User2", avatar: "", description: "", website: "", nfts: Array(repeating: "1", count: 5), rating: "2", id: "125"),
        User(name: "User3", avatar: "", description: "", website: "", nfts: Array(repeating: "1", count: 9), rating: "3", id: "363"),
        User(name: "User4", avatar: "", description: "", website: "", nfts: Array(repeating: "1", count: 100), rating: "4", id: "742"),
        User(name: "User5", avatar: "", description: "", website: "", nfts: Array(repeating: "1", count: 25), rating: "5", id: "473"),
        User(name: "User6", avatar: "", description: "", website: "", nfts: Array(repeating: "1", count: 51), rating: "6", id: "190"),
        User(name: "User7", avatar: "", description: "", website: "", nfts: Array(repeating: "1", count: 87), rating: "7", id: "982"),
        User(name: "User8", avatar: "", description: "", website: "", nfts: Array(repeating: "1", count: 2), rating: "8", id: "865"),
        User(name: "User1", avatar: "", description: "", website: "", nfts: Array(repeating: "1", count: 3), rating: "1", id: "123"),
        User(name: "User2", avatar: "", description: "", website: "", nfts: Array(repeating: "1", count: 5), rating: "2", id: "125"),
        User(name: "User3", avatar: "", description: "", website: "", nfts: Array(repeating: "1", count: 9), rating: "3", id: "363"),
        User(name: "User4", avatar: "", description: "", website: "", nfts: Array(repeating: "1", count: 100), rating: "4", id: "742"),
        User(name: "User5", avatar: "", description: "", website: "", nfts: Array(repeating: "1", count: 25), rating: "5", id: "473"),
        User(name: "User6", avatar: "", description: "", website: "", nfts: Array(repeating: "1", count: 51), rating: "6", id: "190"),
        User(name: "User7", avatar: "", description: "", website: "", nfts: Array(repeating: "1", count: 87), rating: "7", id: "982"),
        User(name: "User8", avatar: "", description: "", website: "", nfts: Array(repeating: "1", count: 2), rating: "8", id: "865"),
    ]
    
    var filteresUsers: [User] = []
    
    func viewDidLoad() {
        filteresUsers = users
    }
    
    func filter(by filter: FilterOption) {
        switch filter {
        case .name:
            filteresUsers = users.sorted { $0.name < $1.name }
        case .rating:
            filteresUsers = users.sorted { $0.rating < $1.rating }
        }
    }
}
