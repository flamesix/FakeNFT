//
//  ProfileSitePresenter.swift
//  FakeNFT
//
//  Created by Soslan Dzampaev on 21.11.2024.
//

import Foundation
import WebKit

protocol ProfileSiteViewProtocol: AnyObject {
    func showProgress(_ progress: Float)
    func hideProgress()
    func loadRequest(_ request: URLRequest)
    func showError(_ message: String)
}

final class ProfileSitePresenter: NSObject {
    // MARK: - Properties
    private weak var view: ProfileSiteViewProtocol?
    private let websiteURL: URL
    private var webView: WKWebView?
    
    // MARK: - Init
    init(view: ProfileSiteViewProtocol?, websiteURL: URL) {
        self.view = view
        self.websiteURL = websiteURL
    }
    
    // MARK: - Public methods
    func setView(_ view: ProfileSiteViewProtocol) {
        self.view = view
    }

    func attachWebView(_ webView: WKWebView) {
        self.webView = webView
        self.webView?.navigationDelegate = self
        self.webView?.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
    }
    
    func loadWebsite() {
        let request = URLRequest(url: websiteURL)
        view?.loadRequest(request)
    }
    
    deinit {
        webView?.removeObserver(self, forKeyPath: "estimatedProgress")
    }
    
    // MARK: - KVO
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            let progress = Float(webView?.estimatedProgress ?? 0)
            view?.showProgress(progress)
            if progress == 1 {
                view?.hideProgress()
            }
        }
    }
}

// MARK: - WKNavigationDelegate
extension ProfileSitePresenter: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        view?.showProgress(0)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        view?.hideProgress()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        view?.hideProgress()
        view?.showError(error.localizedDescription)
    }
}
