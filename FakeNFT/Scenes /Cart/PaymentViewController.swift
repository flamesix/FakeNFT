//
//  PaymentViewController.swift
//  FakeNFT
//
//  Created by Pavel Bobkov on 16.11.2024.
//

import UIKit

protocol PaymentViewProtocol: AnyObject {
    
}

final class PaymentViewController: UIViewController, PaymentViewProtocol {
    
    // MARK: - Properties
    
    private let presenter: PaymentPresenterProtocol
    
    // MARK: - View
    
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
        button.titleLabel?.textColor = .nftWhite
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
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
    
    // MARK: - Private Methods
    
    private func setup() {
        setupViews()
        setupConstraints()
        setupNavigationBarItem()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        [paymentMenuView, userAgreementInfoLabel, userAgreementButton, payButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
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
            payButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func setupNavigationBarItem() {
        navigationItem.title = NSLocalizedString("Cart.paymentScreen", comment: "")
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.backItem?.title = .none
    }
}
