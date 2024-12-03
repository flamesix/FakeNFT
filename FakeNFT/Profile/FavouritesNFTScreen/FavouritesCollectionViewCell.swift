//
//  FavouritesCollectionViewCell.swift
//  FakeNFT
//
//  Created by Soslan Dzampaev on 12.11.2024.
//

import UIKit
import Kingfisher

final class FavouritesCollectionViewCell: UICollectionViewCell {
    var onLikeButtonTapped: (() -> Void)?
    
    // MARK: Private properties
    private let totalStars: Int = 5
    private let nftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let favoriteIcon: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "activeLike"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapLikeButton), for: .touchUpInside)
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .bodyBold
        label.textColor = UIColor(resource: .nftBlack)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var ratingStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .caption1
        label.textColor = UIColor(resource: .nftBlack)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var priceFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "ETH"
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        return formatter
    }()
    
    // MARK: init
    override init(frame: CGRect){
        super.init(frame: frame)
        setupCell()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: setup methods
    private func setupCell() {
        contentView.addSubview(nftImageView)
        contentView.addSubview(favoriteIcon)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(ratingStack)
        
        NSLayoutConstraint.activate([
            nftImageView.widthAnchor.constraint(equalToConstant: 80),
            nftImageView.heightAnchor.constraint(equalToConstant: 80),
            
            favoriteIcon.topAnchor.constraint(equalTo: nftImageView.topAnchor, constant: 5),
            favoriteIcon.trailingAnchor.constraint(equalTo: nftImageView.trailingAnchor, constant: -5),
            favoriteIcon.widthAnchor.constraint(equalToConstant: 21),
            favoriteIcon.heightAnchor.constraint(equalToConstant: 18),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 7),
            titleLabel.leadingAnchor.constraint(equalTo: nftImageView.trailingAnchor, constant: 12),
            
            ratingStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            ratingStack.leadingAnchor.constraint(equalTo: nftImageView.trailingAnchor, constant: 12),
            ratingStack.widthAnchor.constraint(equalToConstant: 68),
            ratingStack.heightAnchor.constraint(equalToConstant: 12),
            
            priceLabel.topAnchor.constraint(equalTo: ratingStack.bottomAnchor, constant: 8),
            priceLabel.leadingAnchor.constraint(equalTo: nftImageView.trailingAnchor, constant: 12),
        ])
    }
    
    func configure(with nft: FavouriteNftModel) {
        if let imageUrlString = nft.images.first, let imageUrl = URL(string: imageUrlString) {
            nftImageView.kf.setImage(with: imageUrl, placeholder: UIImage(named: "placeholderImage"))
        }
        titleLabel.text = nft.name.components(separatedBy: " ").first ?? ""
        configureRatingStackView(for: nft.rating)
        priceLabel.text = formatPrice(nft.price)
    }
    
    
    private func formatPrice(_ price: Double) -> String {
        return priceFormatter.string(from: NSNumber(value: price)) ?? "\(price) ETH"
    }
    
    private func configureRatingStackView(for rating: Int) {
        ratingStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for i in 0..<totalStars {
            let isActive = i < rating
            let starImageView = UIImageView.createStar(isActive: isActive)
            ratingStack.addArrangedSubview(starImageView)
        }
    }
    
    @objc
    private func didTapLikeButton() {
        onLikeButtonTapped?()
    }
}
