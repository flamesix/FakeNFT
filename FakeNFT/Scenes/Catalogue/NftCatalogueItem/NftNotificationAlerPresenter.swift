
import UIKit

enum AlertMessage: String {
    case likeNotification = "likeNotification"
    case orderNotification = "orderNotification"
    
    func localizedString() -> String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}

final class NftNotificationAlerPresenter {
    
    private let viewController: UIViewController
    private let nftNotificationAlertClose = NSLocalizedString("nftNotificationAlertClose", comment: "")
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func showNotificationAlert(with notification: AlertMessage){
        let alert = UIAlertController(title: nil, message: notification.localizedString(), preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: nftNotificationAlertClose, style: .cancel)
        alert.addAction(cancel)
        viewController.present(alert, animated: true)
    }
}
