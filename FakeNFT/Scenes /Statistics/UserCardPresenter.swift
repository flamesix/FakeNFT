import Foundation

protocol UserCardPresenterProtocol {
    var view: UserCardViewControllerProtocol? { get set }
}

final class UserCardPresenter: UserCardPresenterProtocol {
    
    weak var view: UserCardViewControllerProtocol?
    
}
