//
//  NFTTableViewCell.swift
//  FakeNFT
//
//  Created by Soslan Dzampaev on 10.11.2024.
//

import UIKit

final class NFTTableViewCell: UITableViewCell {
    // MARK: - Private Properties
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
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = .caption2
        label.textColor = UIColor(named: "nftBlack")
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
    
    private lazy var priceTitile: UILabel = {
        let label = UILabel()
        label.text = "Цена"
        label.font = .caption2
        label.textColor = UIColor(named: "nftBlack")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .bodyBold
        label.textColor = UIColor(named: "nftBlack")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - setup methods
    private func setupCell() {
        contentView.addSubview(nftImageView)
        contentView.addSubview(favoriteIcon)
        contentView.addSubview(titleLabel)
        contentView.addSubview(authorLabel)
        contentView.addSubview(ratingStack)
        contentView.addSubview(priceLabel)
        contentView.addSubview(priceTitile)
        
        NSLayoutConstraint.activate([
            nftImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nftImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            nftImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            nftImageView.widthAnchor.constraint(equalToConstant: 108),
            nftImageView.heightAnchor.constraint(equalToConstant: 108),
            
            favoriteIcon.topAnchor.constraint(equalTo: nftImageView.topAnchor, constant: 12),
            favoriteIcon.trailingAnchor.constraint(equalTo: nftImageView.trailingAnchor, constant: -12),
            favoriteIcon.widthAnchor.constraint(equalToConstant: 17.64),
            favoriteIcon.heightAnchor.constraint(equalToConstant: 15.75),
            
            titleLabel.leadingAnchor.constraint(equalTo: nftImageView.trailingAnchor, constant: 20),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 39),
            
            ratingStack.leadingAnchor.constraint(equalTo: nftImageView.trailingAnchor, constant: 20),
            ratingStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            ratingStack.widthAnchor.constraint(equalToConstant: 68),
            ratingStack.heightAnchor.constraint(equalToConstant: 12),
            
            authorLabel.leadingAnchor.constraint(equalTo: nftImageView.trailingAnchor, constant: 20),
            authorLabel.topAnchor.constraint(equalTo: ratingStack.bottomAnchor, constant: 5),
            
            priceTitile.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -81),
            priceTitile.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 49),
            
            priceLabel.leadingAnchor.constraint(equalTo: priceTitile.leadingAnchor),
            priceLabel.topAnchor.constraint(equalTo: priceTitile.bottomAnchor, constant: 2),
        ])
    }
    
    func configure(with nft: NFTModel) {
        nftImageView.image = nft.image
        titleLabel.text = nft.title
        authorLabel.text = "от \(nft.author)"
        ratingStack = configureRatingStackView(for: nft.rating)
        priceLabel.text = formatPrice(nft.price)
    }
    
    private func formatPrice(_ price: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "ETH"
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        return formatter.string(from: NSNumber(value: price)) ?? "\(price) ETH"
    }
    
    private func configureRatingStackView(for rating: Int) -> UIStackView {
        let totalStars = 5
        for _ in 0..<rating {
            let activeStar = UIImageView(image: UIImage(named: "starFilled"))
            activeStar.contentMode = .scaleAspectFit
            ratingStack.addArrangedSubview(activeStar)
        }
        
        for _ in 0..<(totalStars - rating) {
            let inactiveStar = UIImageView(image: UIImage(named: "starEmpty"))
            inactiveStar.contentMode = .scaleAspectFit
            ratingStack.addArrangedSubview(inactiveStar)
        }
        return ratingStack
    }
}
