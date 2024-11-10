//
//  NftCollectionsCatalgueViewContoller.swift
//  FakeNFT
//
//  Created by Федор Завьялов on 09.11.2024.
//

import UIKit

final class NftCollectionsCatalgueViewContoller: UIViewController, SettingViewsProtocol {
    
    private var collectionCatalogue: [NftCollectionModel] = []
    private var nftCollectionCatalogueFactory = NftCollectionCatalogueFactory()
    
    private lazy var nftCollectionsSortImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(resource: .nftCatalogueSort)
        imageView.tintColor = .nftBlack
        return imageView
    }()
    
    private lazy var nftCollectionsTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(NftCollectionTableViewCell.self, forCellReuseIdentifier: "collection cell")
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        collectionCatalogue = nftCollectionCatalogueFactory.prepareCatalogue()
        setupView()
        addConstraints()
    }
    
    
    func setupView() {
        [nftCollectionsTableView, nftCollectionsSortImageView].forEach {view.addSubview($0)
        }
    }
    
    func addConstraints() {
       
        nftCollectionsSortImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(46)
            make.right.equalToSuperview().offset(-9)
            make.height.equalTo(42)
            make.width.equalTo(42)
        }
        
        nftCollectionsTableView.snp.makeConstraints { make in
            make.top.equalTo(nftCollectionsSortImageView.snp.bottom).offset(16)
            make.left.equalTo(view).offset(16)
            make.right.equalTo(view).offset(-16)
            make.bottom.equalToSuperview()
        }
    }
    
}

extension NftCollectionsCatalgueViewContoller: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collectionCatalogue.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "collection cell", for: indexPath) as! NftCollectionTableViewCell
        cell.configure(with: collectionCatalogue[indexPath.row])
        return cell
    }
}

extension NftCollectionsCatalgueViewContoller: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
