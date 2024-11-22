
import UIKit

protocol NftCollectionSortProtocol: AnyObject {
    func catalogueUpdate(with sortState: SortedBy?)
}

final class NftCollectionSortAlerPresenter {
    
    weak var delegate: NftCollectionSortProtocol?
    private let sorting = NSLocalizedString("sorting", comment: "")
    private let nftCountSort = NSLocalizedString("nftCountSort", comment: "")
    private let nftNameSort = NSLocalizedString("nftNameSort", comment: "")
    private let sortAlertClose = NSLocalizedString("sortAlertClose", comment: "")
    
    func showSortAlert(on viewController: UIViewController){
        guard let delegate = delegate else { return }
        let alert = UIAlertController(title: sorting, message: nil, preferredStyle: .actionSheet)
        let sortByCount = UIAlertAction(title: nftCountSort, style: .default) { _ in
            let sortState: SortedBy = .nftCount
            delegate.catalogueUpdate(with: sortState)
        }
        let sortByName = UIAlertAction(title: nftNameSort, style: .default) { _ in
            let sortState: SortedBy = .name
            delegate.catalogueUpdate(with: sortState)
        }
        let cancel = UIAlertAction(title: sortAlertClose, style: .cancel)
        alert.addAction(sortByName)
        alert.addAction(sortByCount)
        alert.addAction(cancel)
        viewController.present(alert, animated: true)
    }
}
