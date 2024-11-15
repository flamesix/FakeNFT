//
//  NftCartCell.swift
//  FakeNFT
//
//  Created by Pavel Bobkov on 12.11.2024.
//

import UIKit

final class NftCartCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "NftCartCell"
    static let height: CGFloat = 140
    
    // MARK: - View
    
    private let nftImageView: UIImageView = {
        let image = UIImageView()
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 12
        return image
    }()
    
    private let nftTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.textColor = .textPrimary
        return label
    }()
    
    private let starRatingView = StarRatingView()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = .textPrimary
        label.text = NSLocalizedString("Cart.price", comment: "")
        return label
    }()
    
    private let nftPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.textColor = .textPrimary
        return label
    }()
    
    private let deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "removeCartIcon"), for: .normal)
        return button
    }()
    
    // MARK: - Life-Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Methods
    
    func configure(images: [URL], name: String, rating: Int, price: Float) {
        if let imageUrl = images.first {
            nftImageView.kf.setImage(with: imageUrl)
        }
        nftTitleLabel.text = name
        nftPriceLabel.text = "\(price) ETH"
        starRatingView.setRating(rating)
    }
    
    private func setup() {
        setupView()
        setupConstraints()
    }
    
    private func setupView() {
        [nftImageView, nftTitleLabel, starRatingView,
         priceLabel, nftPriceLabel, deleteButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            nftImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nftImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nftImageView.heightAnchor.constraint(equalToConstant: 108),
            nftImageView.widthAnchor.constraint(equalToConstant: 108),
            
            nftTitleLabel.leadingAnchor.constraint(equalTo: nftImageView.trailingAnchor, constant: 20),
            nftTitleLabel.topAnchor.constraint(equalTo: nftImageView.topAnchor, constant: 8),
            
            starRatingView.leadingAnchor.constraint(equalTo: nftImageView.trailingAnchor, constant: 20),
            starRatingView.topAnchor.constraint(equalTo: nftTitleLabel.bottomAnchor, constant: 4),
            starRatingView.widthAnchor.constraint(equalToConstant: 68),
            starRatingView.heightAnchor.constraint(equalToConstant: 12),
            
            priceLabel.bottomAnchor.constraint(equalTo: nftPriceLabel.topAnchor, constant: -2),
            priceLabel.leadingAnchor.constraint(equalTo: nftImageView.trailingAnchor, constant: 20),
            
            nftPriceLabel.bottomAnchor.constraint(equalTo: nftImageView.bottomAnchor, constant: -8),
            nftPriceLabel.leadingAnchor.constraint(equalTo: nftImageView.trailingAnchor, constant: 20),
            
            deleteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            deleteButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            deleteButton.heightAnchor.constraint(equalToConstant: 40),
            deleteButton.widthAnchor.constraint(equalToConstant: 40),
        ])
    }
}
