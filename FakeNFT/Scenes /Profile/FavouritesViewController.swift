//
//  FavouritesViewController.swift
//  FakeNFT
//
//  Created by Soslan Dzampaev on 12.11.2024.
//

import UIKit

final class FavouritesViewController: UIViewController {
    // MARK: - MockData
    private var nftItems: [NFTModel] = [
        NFTModel(image: UIImage(named: "nftTest2")!, title: "Lilo", author: "John Doe", rating: 3, price: "1,78"),
        NFTModel(image: UIImage(named: "nftCard1")!, title: "Spring", author: "John Doe", rating: 5, price: "1,78"),
        NFTModel(image: UIImage(named: "nftCard1")!, title: "April", author: "John Doe", rating: 3, price: "1,78")
    ]
    
    // MARK: - Private Properties
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
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(FavouritesCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var stubLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.text = "У Вас ещё нет избранных NFT"
        label.textColor = UIColor(named: "nftBlack")
        label.font = .bodyBold
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Life view cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Setup methods
    private func setupUI(){
        addSubviews()
        addConstraints()
        title = "Избранные NFT"
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        view.backgroundColor = .white
    }
    
    private func addSubviews(){
        view.addSubview(collectionView)
        view.addSubview(stubLabel)
    }
    
    private func addConstraints(){
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            stubLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stubLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    // MARK: - Private Methods
    @objc
    private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: UICollectionViewDataSource
extension FavouritesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nftItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? FavouritesCollectionViewCell else {
            return FavouritesCollectionViewCell()
        }
        
        cell.configure(with: nftItems[indexPath.row])
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension FavouritesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow: CGFloat = 2
        let padding: CGFloat = 16
        let totalPadding = padding * itemsPerRow + 7
        let itemWidth = (collectionView.frame.width - totalPadding) / itemsPerRow
        return CGSize(width: itemWidth, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 7
    }
}
