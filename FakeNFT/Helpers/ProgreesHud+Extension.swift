import UIKit
import ProgressHUD

extension ProgressHUD {
    
    static func showIndicator() {
        let loadingLable = NSLocalizedString("Loadiung", comment: "")
        ProgressHUD.show(loadingLable)
        ProgressHUD.colorAnimation = .nftBlack
        ProgressHUD.colorStatus = .nftBlack
        }
    
    static func dismissIndicator() {
        ProgressHUD.dismiss()
    }
}
