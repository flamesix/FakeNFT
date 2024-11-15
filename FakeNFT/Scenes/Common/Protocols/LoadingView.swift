import ProgressHUD

protocol LoadingView {
    func showLoading()
    func hideLoading()
}

extension LoadingView {
    func showLoading() {
        ProgressHUD.showIndicator()
    }

    func hideLoading() {
        ProgressHUD.dismissIndicator()
    }
}
