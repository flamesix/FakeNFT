import UIKit
import SnapKit

protocol NftCollectionViewControllerProtocol: AnyObject {
    var presenter: NftCollectionPresenter? { get set }
}

final class NftCollectionViewController: UIViewController, NftCollectionViewControllerProtocol {
    
    var presenter: NftCollectionPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.viewDidLoad()
    }
    
}

extension NftCollectionViewController: SettingViewsProtocol {
    func setupView() {
        
    }
    
    func addConstraints() {
        
    }
}
