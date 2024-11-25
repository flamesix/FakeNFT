
import UIKit

protocol NftCollectionSortProtocol: AnyObject {
    func catalogueUpdate(with sortState: SortedBy?)
}

final class NftCollectionSortAlerPresenter {
    
    weak var delegate: NftCollectionSortProtocol?
    private let sorting = NSLocalizedString("Sorting", comment: "")
    private let nftCountSort = NSLocalizedString("Nft.count.sort", comment: "")
    private let nftNameSort = NSLocalizedString("Nft.name.sort", comment: "")
    private let sortAlertClose = NSLocalizedString("Sort.alert.close", comment: "")
    
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
