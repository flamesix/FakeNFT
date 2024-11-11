import UIKit

final class NftCatalogueItemCollectionViewCell: UICollectionViewCell {
    
    private lazy var itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        return imageView
    }()
    
//    private lazy var cosmosView: CosmosView = {
//        let cosmosView = CosmosView()
//        cosmosView.settings.fillMode = .init(rawValue: 1)
//        cosmosView.settings.starSize = 12
//        cosmosView.settings.starMargin = 2
//        cosmosView.settings.totalStars = 5
//        return cosmosView
//    }()
}
