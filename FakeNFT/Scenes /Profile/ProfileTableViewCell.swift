//
//  ProfileTableViewCell.swift
//  FakeNFT
//
//  Created by Soslan Dzampaev on 09.11.2024.
//

import Foundation
import UIKit

final class ProfileTableViewCell: UITableViewCell {

    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor(named: "nftBlack")
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    private lazy var chevron: UIImageView = {
        let chevron = UIImageView(image: UIImage(systemName: "chevron.right"))
        chevron.translatesAutoresizingMaskIntoConstraints = false
        return chevron
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpView() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(chevron)

        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: chevron.leadingAnchor, constant: -8),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            chevron.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            chevron.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])

    }

    func setTitleLabel(text: String) {
        titleLabel.text = text
    }
}
