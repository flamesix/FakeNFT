//
//  CurrencyCell.swift
//  FakeNFT
//
//  Created by Pavel Bobkov on 16.11.2024.
//

import UIKit

final class CurrencyCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier: String = "CurrencyCell"
    static let height = CGFloat(45)
    
    // MARK: - View
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 6
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .nftBlackUni
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = .textPrimary
        return label
    }()
    
    private let tickerLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = .nftGreenUni
        return label
    }()
    
    // MARK: - Life-Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func configure(title: String, ticker: String, image: URL) {
        imageView.kf.setImage(with: image)
        titleLabel.text = title
        tickerLabel.text = ticker
    }
    
    func select() {
        contentView.layer.borderColor = UIColor.nftBlackUni.cgColor
    }
    
    func deselect() {
        contentView.layer.borderColor = UIColor.nftLightGrey.cgColor
    }
    
    // MARK: - Private Methods
    
    private func setup() {
        setupView()
        setupConstraints()
    }
    
    private func setupView() {
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.nftLightGrey.cgColor
        contentView.backgroundColor = .nftLightGrey
        
        [imageView, titleLabel, tickerLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            imageView.heightAnchor.constraint(equalToConstant: 36),
            imageView.widthAnchor.constraint(equalToConstant: 36),
            
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 4),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            
            tickerLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 4),
            tickerLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
        ])
    }
}
