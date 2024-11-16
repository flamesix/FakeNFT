import UIKit
import SnapKit

final class NftCollectionCollectionViewCell: UICollectionViewCell, ReuseIdentifying {
    
    private lazy var nftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .bold17
        label.textColor = .nftBlack
        return label
    }()
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.font = .bold17
        label.textColor = .nftBlack
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .medium10
        label.textColor = .nftBlack
        return label
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton()
        button.setImage(.add, for: .normal)
        button.tintColor = .nftBlack
        return button
    }()
    
    private lazy var cartButton: UIButton = {
        let button = UIButton()
        button.setImage(.remove, for: .normal)
        button.tintColor = .nftBlack
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NftCollectionCollectionViewCell: SettingViewsProtocol {
    func setupView() {
        
    }
    
    func addConstraints() {
        
    }
}
