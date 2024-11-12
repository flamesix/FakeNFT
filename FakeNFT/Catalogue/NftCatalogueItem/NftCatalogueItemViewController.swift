//
//  NftCatalogueItemViewController.swift
//  FakeNFT
//
//  Created by Федор Завьялов on 12.11.2024.
//

import UIKit

protocol NftCatalogueItemViewControllerProtocol: AnyObject, ErrorView, LoadingView {
    func displayItems(_ nftCollectionItems: [NftCollectionItem])
}

final class NftCatalogueItemViewController: UIViewController, SettingViewsProtocol  {

    private var catalogue: NftCatalogueCollection
    private var catalogeItems: [NftCollectionItem] = []
    
    private var presenter: NftCatalogueItemPresenter
    
    var activityIndicator = UIActivityIndicatorView()
    
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(resource: .nftCollectionBackwardChevron), for: .normal)
        button.tintColor = .nftBlack
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    
    private lazy var coverImgeView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var catalogueTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.headline3
        label.textColor = .label
        return label
    }()
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.caption2
        label.textColor = .label
        label.text = "Автор коллекции"
        return label
    }()
    
    private lazy var authorButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.nftBlueUni, for: .normal)
        button.titleLabel?.font = UIFont.caption1
        return button
    }()
    
    private lazy var descriptionTextView: UITextView = {
        let label = UITextView()
        label.font = UIFont.caption2
        label.textColor = .label
        label.isScrollEnabled = false
        label.isEditable = false
        label.isSelectable = false
        return label
    }()
    
    private lazy var nftCatalogueCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(NftCatalogueItemCollectionViewCell.self, forCellWithReuseIdentifier: "collectioItem")
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    init(presenter: NftCatalogueItemPresenter, catalogue: NftCatalogueCollection) {
        self.presenter = presenter
        self.catalogue = catalogue
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupView()
        addConstraints()
    }
    
    @objc func backButtonTapped(){
        
    }
    
    func setupView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(backButton)
        contentView.addSubview(coverImgeView)
        contentView.addSubview(catalogueTitleLabel)
        contentView.addSubview(authorLabel)
        contentView.addSubview(authorButton)
        contentView.addSubview(descriptionTextView)
        contentView.addSubview(nftCatalogueCollectionView)
    }
    
    func addConstraints() {
        scrollView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.leading.equalTo(scrollView.snp.leading)
            make.top.equalTo(scrollView.snp.top)
            make.bottom.equalTo(scrollView.snp.bottom)
            make.trailing.equalTo(scrollView.snp.trailing)
        }
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(55)
            make.leading.equalTo(contentView.snp.leading).offset(9)
            make.height.equalTo(24)
            make.width.equalTo(24)
        }
    }
}

extension NftCatalogueItemViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        catalogeItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectioItem", for: indexPath) as! NftCatalogueItemCollectionViewCell
        cell.configureItem(with: catalogeItems[indexPath.row])
        return cell
    }
}

extension NftCatalogueItemViewController: UICollectionViewDelegate {
    
}

extension NftCatalogueItemViewController: NftCatalogueItemViewControllerProtocol {
    func displayItems(_ nftCollectionItems: [NftCollectionItem]) {
        let items = catalogue.nfts
        nftCollectionItems.forEach { collectioItem in
            if items.contains(collectioItem.id) {
                catalogeItems.append(collectioItem)
            }
        }
    }
}
