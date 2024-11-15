
import UIKit

final class NftCollectionSortAlerPresenter {
    
    weak var delegate: NftCollectionSortAlerPresenterProtocol?
    
    func showSortAlert(on viewController: UIViewController){
        guard let delegate = delegate else { return }
        let alert = UIAlertController(title: "Сртировка", message: nil, preferredStyle: .actionSheet)
        let sortByCount = UIAlertAction(title: "По количеству NFT", style: .default) { _ in
            let sortState: SortedBy = .nftCount
            delegate.catalogueUpdate(with: sortState)
        }
        let sortByName = UIAlertAction(title: "По названию", style: .default) { _ in
            let sortState: SortedBy = .name
            delegate.catalogueUpdate(with: sortState)
        }
        let cancel = UIAlertAction(title: "Закрыть", style: .cancel)
        alert.addAction(sortByName)
        alert.addAction(sortByCount)
        alert.addAction(cancel)
        viewController.present(alert, animated: true)
    }
}
