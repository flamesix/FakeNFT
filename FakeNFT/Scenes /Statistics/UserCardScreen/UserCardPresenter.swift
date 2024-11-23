import Foundation

protocol UserCardPresenterProtocol {
    var view: UserCardViewControllerProtocol? { get set }
    func viewDidLoad()
    func getUserWebPage() -> String
    func getNftCollection() -> [String]
}

final class UserCardPresenter: UserCardPresenterProtocol {
    
    weak var view: UserCardViewControllerProtocol?
    
    private let user: User
    
    init(user: User) {
        self.user = user
    }
    
    func viewDidLoad() {
        view?.configureUI(with: user)
    }
    
    func getUserWebPage() -> String {
        user.website
    }
    
    func getNftCollection() -> [String] {
        user.nfts
    }
}
