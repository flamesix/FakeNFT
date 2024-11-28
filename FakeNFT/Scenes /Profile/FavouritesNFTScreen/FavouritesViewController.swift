//
//  FavouritesViewController.swift
//  FakeNFT
//
//  Created by Soslan Dzampaev on 12.11.2024.
//

import UIKit
import ProgressHUD

final class FavouritesViewController: UIViewController, FavouritesView {
    private var presenter: FavouritesPresenter?
    private var nftItems: [FavouriteNftModel] = []

    // MARK: - UI Components
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
        label.textColor = UIColor(resource: .nftBlack)
        label.font = .bodyBold
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Init
    init(favoriteNfts: [String?]) {
        super.init(nibName: nil, bundle: nil)
        self.presenter = FavouritesPresenter(view: self, favoriteNfts: favoriteNfts)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }

    // MARK: - Setup Methods
    private func setupUI() {
        addSubviews()
        addConstraints()
        title = "Избранные NFT"
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        view.backgroundColor = .white
    }

    private func addSubviews() {
        view.addSubview(collectionView)
        view.addSubview(stubLabel)
    }

    private func addConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            stubLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stubLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    // MARK: - Actions
    @objc
    private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }

    // MARK: - FavouritesView Protocol Methods
    func showLoading() {
        ProgressHUD.show("Загрузка...")
    }

    func hideLoading() {
        ProgressHUD.dismiss()
    }

    func showError(_ message: String) {
        showErrorAlert(with: message)
    }

    func updateNftItems(_ items: [FavouriteNftModel]) {
        self.nftItems = items
        collectionView.reloadData()
    }

    func showStubUI() {
        collectionView.isHidden = true
        stubLabel.isHidden = false
    }

    func hideStubUI() {
        collectionView.isHidden = false
        stubLabel.isHidden = true
    }

    private func showErrorAlert(with message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true, completion: nil)
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

        let nft = nftItems[indexPath.row]
        cell.configure(with: nft)
        cell.onLikeButtonTapped = { [weak self] in
            guard let self = self else { return }
            self.presenter?.handleLikeAction(for: nft)
        }

        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension FavouritesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow: CGFloat = 2
        let padding: CGFloat = 16
        let totalPadding = padding * itemsPerRow
        let itemWidth = (collectionView.frame.width - totalPadding) / itemsPerRow
        return CGSize(width: itemWidth, height: 80)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }

    func collectionView(_ collectionView: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 7
    }
}

extension Notification.Name {
    static let favouritesDidUpdate = Notification.Name("favouritesDidUpdate")
}
