import UIKit
import SnapKit

protocol UserCardViewControllerProtocol: AnyObject {
    var presenter: UserCardPresenterProtocol? { get set }
}

final class UserCardViewController: UIViewController, UserCardViewControllerProtocol {
    
    var presenter: UserCardPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

extension UserCardViewController: SettingViewsProtocol {
    func setupView() {
        
    }
    
    func addConstraints() {
        
    }
}
