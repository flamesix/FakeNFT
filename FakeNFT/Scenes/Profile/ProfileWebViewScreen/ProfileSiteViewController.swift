//
//  ProfileSiteViewController.swift
//  FakeNFT
//
//  Created by Soslan Dzampaev on 13.11.2024.
//

import UIKit
import WebKit

final class ProfileSiteViewController: UIViewController, ProfileSiteViewProtocol {
    // MARK: - Private properties
    private let presenter: ProfileSitePresenter
    
    private lazy var progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.tintColor = UIColor(resource: .nftBlack)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(weight: .bold)
        let image = UIImage(systemName: "chevron.backward", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = UIColor(resource: .nftBlack)
        button.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.backgroundColor = UIColor(resource: .nftWhite)
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    // MARK: - Init
    init(websiteURL: URL) {
        self.presenter = ProfileSitePresenter(view: nil, websiteURL: websiteURL)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life view cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setView(self)
        setupUI()
        presenter.attachWebView(webView)
        presenter.loadWebsite()
    }
    
    // MARK: - Setup UI methods
    private func setupUI() {
        addSubviews()
        addConstraints()
        title = "О разработчике"
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        view.backgroundColor = UIColor(resource: .nftWhite)
    }
    
    private func addSubviews() {
        view.addSubview(webView)
        view.addSubview(progressView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            webView.topAnchor.constraint(equalTo: progressView.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc
    private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - ProfileSiteViewProtocol
    func showProgress(_ progress: Float) {
        progressView.progress = progress
        progressView.isHidden = progress == 1
    }
    
    func hideProgress() {
        progressView.isHidden = true
    }
    
    func loadRequest(_ request: URLRequest) {
        webView.load(request)
    }
    
    func showError(_ message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
