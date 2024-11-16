import Foundation

protocol NftCollectionPresenterProtocol {
    var view: NftCollectionViewControllerProtocol? { get set }
    func viewDidLoad()
}

final class NftCollectionPresenter: NftCollectionPresenterProtocol {
    
    weak var view: NftCollectionViewControllerProtocol?
    
    func viewDidLoad() {
        
    }
}
