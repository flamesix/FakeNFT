//
//  MyNFTViewController.swift
//  FakeNFT
//
//  Created by Soslan Dzampaev on 10.11.2024.
//

import UIKit
import ProgressHUD

final class MyNFTViewController: UIViewController {
    private var presenter: MyNFTPresenter?
    private var nftItems: [FavouriteNftModel] = []

    // MARK: - UI Components
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(weight: .bold)
        let image = UIImage(systemName: "chevron.backward", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = UIColor(named: "nftBlack")
        button.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var filterButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "filterButton"), for: .normal)
        button.tintColor = UIColor(named: "nftBlack")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(showMenu), for: .touchUpInside)
        return button
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.register(NFTTableViewCell.self, forCellReuseIdentifier: "NFTTableViewCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private lazy var stubLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.text = "У Вас ещё нет NFT"
        label.textColor = UIColor(named: "nftBlack")
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Init
    init(myNfts: [String]) {
        super.init(nibName: nil, bundle: nil)
        self.presenter = MyNFTPresenter(view: self, myNfts: myNfts)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life view cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.viewDidLoad()
    }

    // MARK: - Setup UI methods
    private func setupUI(){
        view.backgroundColor = .white
        title = "Мои NFT"
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: filterButton)

        view.addSubview(tableView)
        view.addSubview(stubLabel)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            stubLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stubLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    // MARK: - Actions
    @objc
    private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }

    @objc
    private func showMenu(){
        let alert = UIAlertController(title: "Сортировка", message: nil, preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: "По цене", style: .default) { _ in
            self.presenter?.didSelectSortOption(.price)
        })

        alert.addAction(UIAlertAction(title: "По рейтингу", style: .default) { _ in
            self.presenter?.didSelectSortOption(.rating)
        })

        alert.addAction(UIAlertAction(title: "По названию", style: .default) { _ in
            self.presenter?.didSelectSortOption(.name)
        })

        alert.addAction(UIAlertAction(title: "Закрыть", style: .cancel))

        present(alert, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension MyNFTViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return nftItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NFTTableViewCell", for: indexPath) as? NFTTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        let nft = nftItems[indexPath.row]
        cell.configure(with: nft)
        return cell
    }
}

// MARK: - MyNFTView Protocol Methods
extension MyNFTViewController: MyNFTView {
    func updateNftItems(_ items: [FavouriteNftModel]) {
        self.nftItems = items
        tableView.reloadData()
    }
    
    func showLoading() {
        ProgressHUD.show("Загрузка...")
    }

    func hideLoading() {
        ProgressHUD.dismiss()
    }

    func showError(_ message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОК", style: .default))
        present(alert, animated: true)
    }

    func showStubUI() {
        filterButton.isHidden = true
        tableView.isHidden = true
        stubLabel.isHidden = false
    }

    func hideStubUI() {
        filterButton.isHidden = false
        tableView.isHidden = false
        stubLabel.isHidden = true
    }
}
