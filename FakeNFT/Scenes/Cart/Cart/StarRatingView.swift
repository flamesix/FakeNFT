//
//  StarRatingView.swift
//  FakeNFT
//
//  Created by Pavel Bobkov on 12.11.2024.
//

import UIKit

final class StarRatingView: UIView {
    
    // MARK: - Properties
    
    private var starImageViews: [UIImageView] = []
    private let maxRating = 5
    
    // MARK: - View
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 4
        return stack
    }()
    
    // MARK: - Init
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    // MARK: - Methods
    
    func setRating(_ rating: Int) {
        for (index, imageView) in starImageViews.enumerated() {
            if index < rating {
                imageView.tintColor = .nftYellowUni
            } else {
                imageView.tintColor = .nftLightGrey
            }
        }
    }
    
    private func setup() {
        self.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        for _ in 0..<maxRating {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.image = UIImage(named: "RatingStarIcon")?.withRenderingMode(.alwaysTemplate)
            
            starImageViews.append(imageView)
            stackView.addArrangedSubview(imageView)
        }
    }
}
