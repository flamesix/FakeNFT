//
//  FavouritesCollectionViewCell.swift
//  FakeNFT
//
//  Created by Soslan Dzampaev on 12.11.2024.
//

import UIKit

final class FavouritesCollectionViewCell: UICollectionViewCell {
    // MARK: Private properties
    private let nftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let favoriteIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "heart.fill"))
        imageView.tintColor = UIColor(named: "nftWhiteUni")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .bodyBold
        label.textColor = UIColor(named: "nftBlack")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10)
        label.textColor = .yellow
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .caption1
        label.textColor = UIColor(named: "nftBlack")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: init
    override init(frame: CGRect){
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: setup methods
    private func setupCell() {
        contentView.addSubview(nftImageView)
        contentView.addSubview(favoriteIcon)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(ratingLabel)
        
        NSLayoutConstraint.activate([
            nftImageView.widthAnchor.constraint(equalToConstant: 80),
            nftImageView.heightAnchor.constraint(equalToConstant: 80),
            
            favoriteIcon.topAnchor.constraint(equalTo: nftImageView.topAnchor, constant: 12),
            favoriteIcon.trailingAnchor.constraint(equalTo: nftImageView.trailingAnchor, constant: -12),
            favoriteIcon.widthAnchor.constraint(equalToConstant: 17.64),
            favoriteIcon.heightAnchor.constraint(equalToConstant: 15.75),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 7),
            titleLabel.leadingAnchor.constraint(equalTo: nftImageView.trailingAnchor, constant: 12),
            
            ratingLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            ratingLabel.leadingAnchor.constraint(equalTo: nftImageView.trailingAnchor, constant: 12),
            
            priceLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 8),
            priceLabel.leadingAnchor.constraint(equalTo: nftImageView.trailingAnchor, constant: 12)
        ])
    }
    
    func configure(with nft: NFTModel) {
        nftImageView.image = nft.image
        titleLabel.text = nft.title
        ratingLabel.text = String(repeating: "⭐", count: nft.rating)
        priceLabel.text = "\(nft.price) ETH"
    }
}
