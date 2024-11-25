//
//  PaymentSuccessViewController.swift
//  FakeNFT
//
//  Created by Pavel Bobkov on 22.11.2024.
//

import UIKit

final class PaymentSuccessViewController: UIViewController {
    
    // MARK: - View
    
    private let contentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "success_image")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let successTitle: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("Cart.successPayment", comment: "")
        label.textColor = .nftBlack
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let returnToCatalogButton: UIButton = {
        let button = UIButton()
        button.setTitle(NSLocalizedString("Cart.returnToCatalog", comment: ""), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        button.setTitleColor(UIColor.nftWhite, for: .normal)
        button.backgroundColor = .nftBlack
        button.layer.masksToBounds = false
        button.layer.cornerRadius = 16
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    // MARK: - Lyfe-Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - Private Methods
    
    private func setup() {
        setupViews()
        setupConstraints()
        setupNavigationBarItem()
    }
    
    private func setupViews() {
        view.backgroundColor = .background
        
        view.addSubview(contentStack)
        view.addSubview(returnToCatalogButton)
        contentStack.addArrangedSubview(imageView)
        contentStack.addArrangedSubview(successTitle)
        
        returnToCatalogButton.addTarget(self, action: #selector(returnToCatalogButtonTapped), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            contentStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
            contentStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -36),
            
            imageView.heightAnchor.constraint(equalToConstant: 278),
            
            returnToCatalogButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            returnToCatalogButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            returnToCatalogButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            returnToCatalogButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
    
    private func setupNavigationBarItem() {
        self.navigationItem.hidesBackButton = true
    }
    
    @objc private func returnToCatalogButtonTapped() {        
        if let tabBarController = self.tabBarController {
            tabBarController.selectedIndex = TabBarTags.catalog.rawValue
            
            if let navController = tabBarController.viewControllers?[TabBarTags.cart.rawValue] as? UINavigationController {
                navController.popToRootViewController(animated: true)
            }
        }
    }
}
