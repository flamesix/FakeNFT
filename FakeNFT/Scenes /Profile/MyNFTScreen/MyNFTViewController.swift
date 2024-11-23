//
//  MyNFTViewController.swift
//  FakeNFT
//
//  Created by Soslan Dzampaev on 10.11.2024.
//

import UIKit

final class MyNFTViewController: UIViewController, UITableViewDelegate {
    // MARK: Mock Data
    private var nftItems: [NFTModel] = [
        NFTModel(image: UIImage(named: "nftCard1")!, title: "Lilo", author: "John Doe", rating: 0, price: 1.78),
        NFTModel(image: UIImage(named: "nftCard1")!, title: "Spring", author: "John Doe", rating: 3, price: 1.78),
        NFTModel(image: UIImage(named: "nftCard1")!, title: "April", author: "John Doe", rating: 0, price: 1.78)
    ]
    
    // MARK: - Private Properties
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
    
    private lazy var filterButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "filterButton"), for: .normal)
        button.tintColor = UIColor(resource: .nftBlack)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(showMenu), for: .touchUpInside)
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
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
        label.textColor = UIColor(resource: .nftBlack)
        label.font = .bodyBold
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Life view cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Setup UI methods
    private func setupUI(){
        addSubviews()
        addConstraints()
        title = "Мои NFT"
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: filterButton)
        view.backgroundColor = .white
    }
    
    private func addSubviews(){
        view.addSubview(tableView)
        view.addSubview(stubLabel)
    }
    
    private func addConstraints(){
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            stubLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stubLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func showStubUI(){
        // TO DO: прописать логику
        filterButton.isHidden = true
        stubLabel.isHidden = false
    }
    
    // MARK: - Private methods
    @objc
    private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func showMenu(){
        let alert = UIAlertController(title: NSLocalizedString("sort", comment: ""), message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "По цене", style: .default) { _ in
            print("По цене")
        })
        
        alert.addAction(UIAlertAction(title: "По рейтингу", style: .default) { _ in
            print("По рейтингуе")
        })
        
        alert.addAction(UIAlertAction(title: "По названию", style: .default) { _ in
            print("По названию")
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
        cell.configure(with: nftItems[indexPath.row])
        return cell
    }
}
