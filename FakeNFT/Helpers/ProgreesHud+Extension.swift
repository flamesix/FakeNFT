import UIKit
import ProgressHUD

extension ProgressHUD {
    
    static func showIndicator() {
        ProgressHUD.show("Загрузка...")
        ProgressHUD.colorAnimation = .nftBlack
        ProgressHUD.colorStatus = .nftBlack
        }
    
    static func dismissIndicator() {
        ProgressHUD.dismiss()
    }
}
