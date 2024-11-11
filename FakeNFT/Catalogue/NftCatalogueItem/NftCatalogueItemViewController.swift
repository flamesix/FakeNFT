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

final class NftCatalogueItemViewController: UIViewController  {
    
    private var catalogue: NftCatalogueCollection
    private var catalogeItems: [NftCollectionItem] = []
    
    private var presenter: NftCatalogueItemPresenter
    
    var activityIndicator = UIActivityIndicatorView()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .systemBackground
        return scrollView
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
    
    private lazy var descriptionLabel: UITextView = {
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}


extension NftCatalogueItemViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        catalogeItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
}

extension NftCatalogueItemViewController: UICollectionViewDelegate {
    
}

extension NftCatalogueItemViewController: NftCatalogueItemViewControllerProtocol {
    func displayItems(_ nftCollectionItems: [NftCollectionItem]) {
        <#code#>
    }
}
