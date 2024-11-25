//
//  PaymentViewController.swift
//  FakeNFT
//
//  Created by Pavel Bobkov on 16.11.2024.
//

import UIKit

protocol PaymentViewProtocol: AnyObject, ErrorView, LoadingView {
    func updateCollection()
    func showSuccessPaymnetView()
    func showPayError()
    var presenter: PaymentPresenterProtocol { get set }
}

final class PaymentViewController: UIViewController, PaymentViewProtocol {
    
    // MARK: - Properties
    
    var presenter: PaymentPresenterProtocol
    
    // MARK: - View
    
    internal lazy var activityIndicator = UIActivityIndicatorView()
    
    private let currenciesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 7
        layout.minimumInteritemSpacing = 7
        let collecion = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collecion.allowsMultipleSelection = false
        collecion.backgroundColor = .background
        return collecion
    }()
    
    private let paymentMenuView: UIView = {
        let view = UIView()
        view.backgroundColor = .nftLightGrey
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 12
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()
    
    private let userAgreementInfoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textPrimary
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.text = NSLocalizedString("Cart.userAgreementInfo", comment: "")
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let userAgreementButton: UIButton = {
        let button = UIButton()
        button.setTitle(NSLocalizedString("Cart.userAgreement", comment: ""), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13, weight: .regular)
        button.setTitleColor(.nftBlueUni, for: .normal)
        button.titleLabel?.textAlignment = .left
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    private let payButton: UIButton = {
        let button = UIButton()
        button.setTitle(NSLocalizedString("Cart.toPay", comment: ""), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        button.setTitleColor(UIColor.nftWhite, for: .normal)
        button.backgroundColor = .nftBlack
        button.layer.masksToBounds = false
        button.layer.cornerRadius = 16
        button.clipsToBounds = true
        return button
    }()
    
    // MARK: - Init
    
    init(presenter: PaymentPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lyfe-Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        presenter.viewDidLoad()
    }
    
    // MARK: - Public Methods
    
    func updateCollection() {
        currenciesCollectionView.reloadData()
    }
    
    func showSuccessPaymnetView() {
        let paymentSuccessViewController = PaymentSuccessViewController()
        navigationController?.pushViewController(paymentSuccessViewController, animated: true)
    }
    
    func showPayError() {
        let alert = UIAlertController(title: NSLocalizedString("Cart.error.payment", comment: ""),
                                      message: nil,
                                      preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: NSLocalizedString("Cart.error.cancel", comment: ""), style: .default) { _ in }
        
        let repeatAction = UIAlertAction(title: NSLocalizedString("Cart.error.repeat", comment: ""), style: .default) { [weak self] _ in
            self?.presenter.payOrder()
        }
        
        alert.addAction(cancelAction)
        alert.addAction(repeatAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Private Methods
    
    private func setup() {
        setupViews()
        setupConstraints()
        setupCollectionView()
        setupNavigationBarItem()
    }
    
    private func setupViews() {
        view.backgroundColor = .background
        
        [currenciesCollectionView, paymentMenuView, userAgreementInfoLabel,
         userAgreementButton, payButton, activityIndicator].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        userAgreementButton.addTarget(self, action: #selector(userAgreementButtonTapped), for: .touchUpInside)
        payButton.addTarget(self, action: #selector(payButtonTapped), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            currenciesCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            currenciesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            currenciesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            currenciesCollectionView.bottomAnchor.constraint(equalTo: paymentMenuView.topAnchor),
            
            paymentMenuView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            paymentMenuView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            paymentMenuView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            paymentMenuView.heightAnchor.constraint(equalToConstant: 186),
            
            userAgreementInfoLabel.topAnchor.constraint(equalTo: paymentMenuView.topAnchor, constant: 16),
            userAgreementInfoLabel.leadingAnchor.constraint(equalTo: paymentMenuView.leadingAnchor, constant: 16),
            userAgreementInfoLabel.trailingAnchor.constraint(equalTo: paymentMenuView.trailingAnchor, constant: -16),
            
            userAgreementButton.topAnchor.constraint(equalTo: userAgreementInfoLabel.bottomAnchor),
            userAgreementButton.leadingAnchor.constraint(equalTo: paymentMenuView.leadingAnchor, constant: 16),
            userAgreementButton.trailingAnchor.constraint(equalTo: paymentMenuView.trailingAnchor, constant: -16),
            
            payButton.topAnchor.constraint(equalTo: userAgreementButton.bottomAnchor, constant: 16),
            payButton.leadingAnchor.constraint(equalTo: paymentMenuView.leadingAnchor, constant: 20),
            payButton.trailingAnchor.constraint(equalTo: paymentMenuView.trailingAnchor, constant: -20),
            payButton.heightAnchor.constraint(equalToConstant: 60),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    private func setupNavigationBarItem() {
        navigationItem.title = NSLocalizedString("Cart.paymentScreen", comment: "")
        navigationController?.navigationBar.tintColor = .nftBlack
        navigationController?.navigationBar.backItem?.title = .none
    }
    
    private func setupCollectionView() {
        currenciesCollectionView.dataSource = self
        currenciesCollectionView.delegate = self
        currenciesCollectionView.register(CurrencyCell.self, forCellWithReuseIdentifier: CurrencyCell.identifier)
    }
    
    @objc private func userAgreementButtonTapped() {
        let urlString = PaymentConstants.userAgreementUrl.rawValue
        let webViewController = WebViewController(urlString: urlString)
        navigationController?.pushViewController(webViewController, animated: true)
    }
    
    @objc private func payButtonTapped() {
        presenter.payOrder()
    }
}

// MARK: - UICollectionViewDataSource

extension PaymentViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.getCurrencyNumber()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CurrencyCell.identifier, for: indexPath) as? CurrencyCell else {
            return UICollectionViewCell()
        }
        
        presenter.configureCell(for: cell, with: indexPath)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PaymentViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let indent = CGFloat(4)
        let columns = CGFloat(2)
        return CGSize(width: collectionView.bounds.width / columns - indent, height: CurrencyCell.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CurrencyCell else { return }
        cell.select()
        presenter.setCurrency(by: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CurrencyCell else { return }
        cell.deselect()
    }
}
