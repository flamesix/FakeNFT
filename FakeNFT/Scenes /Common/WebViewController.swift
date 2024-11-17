import UIKit
import WebKit
import SnapKit

final class WebViewController: UIViewController, WKNavigationDelegate {

    private let url: String

    // MARK: - UIElements
    private lazy var activityIndicator = UIActivityIndicatorView()

    lazy var webView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
        return webView
    }()

    // MARK: - Init
    init(url: String) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        openUrl()
    }

    // MARK: - Methods
    @objc private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    private func openUrl() {
        guard let url = URL(string: url) else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

extension WebViewController {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityIndicator.stopAnimating()
    }
}

// MARK: - SettingView
extension WebViewController: SettingViewsProtocol {
    func setupView() {
        view.backgroundColor = .background
        webView.navigationDelegate = self
        view.addSubviews(webView)
        webView.addSubviews(activityIndicator)
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        addConstraints()
        setupNavigationBar()
    }
    
    func addConstraints() {
        webView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        activityIndicator.snp.makeConstraints { $0.center.equalToSuperview() }
    }
    
    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(didTapBackButton))
        navigationItem.leftBarButtonItem?.tintColor = .nftBlack
    }
}
