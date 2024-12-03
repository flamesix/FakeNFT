//
//  UIImageView+Extensions.swift
//  FakeNFT
//
//  Created by Soslan Dzampaev on 19.11.2024.
//

import UIKit

extension UIImageView {
    static func createStar(isActive: Bool) -> UIImageView {
        let imageName = isActive ? "starFilled" : "starEmpty"
        let starImageView = UIImageView(image: UIImage(named: imageName))
        starImageView.contentMode = .scaleAspectFit
        return starImageView
    }
}
