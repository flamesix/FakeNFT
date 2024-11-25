
import UIKit

enum AlertMessage: String {
    case likeNotification = "Like.notification"
    case orderNotification = "Order.notification"
    
    func localizedString() -> String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}

final class NftNotificationAlerPresenter {
    
    private let viewController: UIViewController
    private let nftNotificationAlertClose = NSLocalizedString("Nft.notification.alert.close", comment: "")
    
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
