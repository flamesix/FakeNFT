//
//  CartViewController.swift
//  FakeNFT
//
//  Created by Pavel Bobkov on 12.11.2024.
//

import UIKit

protocol CartViewProtocol: AnyObject {
    
}

final class CartViewController: UIViewController {
    
    // MARK: - Properties
    
    private let presenter: CartPresenterProtocol
    
    // MARK: - Views
    
    private let nftTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private let cartMenuView: UIView = {
        let view = UIView()
        view.backgroundColor = .nftLightGrey
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 12
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()
    
    private let nftCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textPrimary
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    private let totalCostLabel: UILabel = {
        let label = UILabel()
        label.textColor = .nftGreenUni
        label.font = .systemFont(ofSize: 17, weight: .bold)
        return label
    }()
    
    private let paymentButton: UIButton = {
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
    
    init(presenter: CartPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lyfe-Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setup()
    }
    
    // MARK: - Methods
    
    private func setup() {
        setupViews()
        setupConstraints()
        setupTableView()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        [nftTableView, cartMenuView, paymentButton, nftCountLabel, totalCostLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            nftTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            nftTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nftTableView.bottomAnchor.constraint(equalTo: cartMenuView.topAnchor),
            nftTableView.topAnchor.constraint(equalTo: view.topAnchor),
            
            cartMenuView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cartMenuView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cartMenuView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            cartMenuView.heightAnchor.constraint(equalToConstant: 76),
            
            paymentButton.heightAnchor.constraint(equalToConstant: 44),
            paymentButton.trailingAnchor.constraint(equalTo: cartMenuView.trailingAnchor, constant: -16),
            paymentButton.centerYAnchor.constraint(equalTo: cartMenuView.centerYAnchor),
            paymentButton.leadingAnchor.constraint(equalTo: returnTheLongestLabel(nftCountLabel, totalCostLabel).trailingAnchor, constant: 24),
            
            nftCountLabel.leadingAnchor.constraint(equalTo: cartMenuView.leadingAnchor, constant: 16),
            nftCountLabel.topAnchor.constraint(equalTo: cartMenuView.topAnchor, constant: 16),
            totalCostLabel.leadingAnchor.constraint(equalTo: cartMenuView.leadingAnchor, constant: 16),
            totalCostLabel.bottomAnchor.constraint(equalTo: cartMenuView.bottomAnchor, constant: -16),
        ])
    }
    
    private func setupTableView() {
        nftTableView.register(NftCartCell.self, forCellReuseIdentifier: NftCartCell.identifier)
        nftTableView.dataSource = self
        nftTableView.delegate = self
    }
    
    private func returnTheLongestLabel(_ firstLabel: UILabel, _ secondLabel: UILabel) -> UILabel {
        return firstLabel.bounds.width > secondLabel.bounds.width ? firstLabel : secondLabel
    }
}

// MARK: - CartViewProtocol

extension CartViewController: CartViewProtocol {
    
}

// MARK: - UITableViewDataSource

extension CartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: NftCartCell.identifier,
            for: indexPath
        ) as? NftCartCell else {
            return UITableViewCell()
        }
        
        cell.selectionStyle = .none
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension CartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        NftCartCell.height
    }
}
