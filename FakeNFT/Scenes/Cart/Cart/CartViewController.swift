//
//  CartViewController.swift
//  FakeNFT
//
//  Created by Pavel Bobkov on 12.11.2024.
//

import UIKit

protocol CartViewProtocol: AnyObject, ErrorView, LoadingView {
    func updateCart()
    func showEmptyInfo()
    func presentDeleteNftScreen(for nft: Nft, from nfts: [Nft], delegate: DeleteNftPresenterDelegate)
    var presenter: CartPresenterProtocol { get set }
}

final class CartViewController: UIViewController, CartViewProtocol {
    
    // MARK: - Properties
    
    var presenter: CartPresenterProtocol
    
    // MARK: - Views
    
    private let cartEmptyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textPrimary
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.textAlignment = .center
        label.text = NSLocalizedString("Cart.isEmpty", comment: "")
        label.isHidden = true
        return label
    }()
    
    private let nftTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .background
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
        button.setTitle(NSLocalizedString("Cart.toPaymentScreen", comment: ""), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        button.setTitleColor(UIColor.nftWhite, for: .normal)
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
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideContent()
        presenter.viewDidLoad()
    }
    
    // MARK: - Public Methods
    
    func updateCart() {
        nftTableView.isHidden = false
        cartMenuView.isHidden = false
        
        nftTableView.reloadData()
        setupNavigationBarItem()
        
        nftCountLabel.text = "\(presenter.getNumberOfNftInOrder()) NFT"
        totalCostLabel.text = "\(presenter.getOrderTotalCost()) ETH"
    }
    
    func showEmptyInfo() {
        hideContent()
        cartEmptyLabel.isHidden = false
    }
    
    func presentDeleteNftScreen(for nft: Nft, from nfts: [Nft], delegate: DeleteNftPresenterDelegate) {
        let deleteNftAssembly = DeleteNftAssembly()
        let deleteNftController = deleteNftAssembly.build(delegate: delegate, deletedNft: nft, allNft: nfts)
        deleteNftController.modalPresentationStyle = .overFullScreen
        present(deleteNftController, animated: true)
    }
    
    // MARK: - Private Methods
    
    private func setup() {
        setupViews()
        setupConstraints()
        setupTableView()
    }
    
    private func setupViews() {
        view.backgroundColor = .background
        
        [nftTableView, cartMenuView, cartEmptyLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        [paymentButton, nftCountLabel, totalCostLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            cartMenuView.addSubview($0)
        }
        
        nftTableView.isHidden = true
        cartMenuView.isHidden = true
        
        paymentButton.addTarget(self, action: #selector(openPaymentScreen), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            cartEmptyLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            cartEmptyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
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
            totalCostLabel.bottomAnchor.constraint(equalTo: cartMenuView.bottomAnchor, constant: -16)
        ])
    }
    
    private func setupTableView() {
        nftTableView.register(NftCartCell.self, forCellReuseIdentifier: NftCartCell.identifier)
        nftTableView.dataSource = self
        nftTableView.delegate = self
    }
    
    private func setupNavigationBarItem() {
        let sortButton = UIBarButtonItem(image: UIImage(named: "sortIcon"), style: .plain, target: self, action: #selector(sortButtonTapped))
        sortButton.tintColor = .nftBlack
        navigationItem.rightBarButtonItem = sortButton
        definesPresentationContext = true
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    private func returnTheLongestLabel(_ firstLabel: UILabel, _ secondLabel: UILabel) -> UILabel {
        return firstLabel.intrinsicContentSize.width > secondLabel.intrinsicContentSize.width ? firstLabel : secondLabel
    }
    
    private func hideContent() {
        nftTableView.isHidden = true
        cartMenuView.isHidden = true
        cartEmptyLabel.isHidden = true
        navigationItem.rightBarButtonItem = .none
    }
    
    @objc private func openPaymentScreen() {
        let paymentAssembly = PaymentAssembly()
        let paymentController = paymentAssembly.build()
        paymentController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(paymentController, animated: true)
    }
    
    @objc private func sortButtonTapped() {
        let actionSheet = UIAlertController(title: nil, message: NSLocalizedString("Cart.sort", comment: ""), preferredStyle: .actionSheet)
        
        let sortByPriceAction = UIAlertAction(title: NSLocalizedString("Cart.sortByPrice", comment: ""), style: .default) { [weak self] _ in
            self?.presenter.sortBy(.byPrice)
        }
        
        let sortByRatingAction = UIAlertAction(title: NSLocalizedString("Cart.sortByRating", comment: ""), style: .default) { [weak self] _ in
            self?.presenter.sortBy(.byRating)
        }
        
        let sortByNameAction = UIAlertAction(title: NSLocalizedString("Cart.sortByName", comment: ""), style: .default) { [weak self] _ in
            self?.presenter.sortBy(.byName)
        }
        
        let cancelAction = UIAlertAction(title: NSLocalizedString("Cart.close", comment: ""), style: .cancel, handler: nil)
        
        actionSheet.addAction(sortByPriceAction)
        actionSheet.addAction(sortByRatingAction)
        actionSheet.addAction(sortByNameAction)
        actionSheet.addAction(cancelAction)
        
        present(actionSheet, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource

extension CartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.getNumberOfNftInOrder()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: NftCartCell.identifier,
            for: indexPath
        ) as? NftCartCell else {
            return UITableViewCell()
        }
        
        cell.selectionStyle = .none
        presenter.configureCell(for: cell, with: indexPath)
        cell.delegate = self
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension CartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        NftCartCell.height
    }
}

// MARK: - NftCartCellDelegate

extension CartViewController: NftCartCellDelegate {
    func deleteNft(from cell: NftCartCell) {
        guard let indexPath = nftTableView.indexPath(for: cell) else { return }
        presenter.deleteNft(from: indexPath)
    }
}
