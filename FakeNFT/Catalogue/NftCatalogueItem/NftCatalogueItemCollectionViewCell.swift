import UIKit

enum Rank: Int {
    case one = 1, two = 2, three = 3, four = 4, five = 5, zero = 0
}

final class NftCatalogueItemCollectionViewCell: UICollectionViewCell, SettingViewsProtocol {

    private var rank: Rank?
    
    private lazy var itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        return imageView
    }()
    
    private lazy var likeImageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(resource: .nftCollectionCartHeart)
        imageView.image = image
        imageView.tintColor = .nftWhite
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        return imageView
    }()
    
    private lazy var hStack: UIStackView = {
        let stack = UIStackView()
        stack.addArrangedSubview(starImage1)
        stack.addArrangedSubview(starImage2)
        stack.addArrangedSubview(starImage3)
        stack.addArrangedSubview(starImage4)
        stack.addArrangedSubview(starImage5)
        stack.spacing = 2
        stack.axis = .horizontal
    }()
    
    private lazy var starImage1: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star.fill")
        imageView.tintColor = .nftLightGrey
        return imageView
    }()
    
    private lazy var starImage2: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star.fill")
        imageView.tintColor = .nftLightGrey
        return imageView
    }()
    
    private lazy var starImage3: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star.fill")
        imageView.tintColor = .nftLightGrey
        return imageView
    }()
    
    private lazy var starImage4: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star.fill")
        imageView.tintColor = .nftLightGrey
        return imageView
    }()
    
    private lazy var starImage5: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star.fill")
        imageView.tintColor = .nftLightGrey
        return imageView
    }()
    
    private lazy var itmeTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.bodyBold
        label.textColor = .nftBlack
        return label
    }()
    
    private lazy var priceLable: UILabel = {
        let label = UILabel()
        label.font = UIFont.caption3
        label.textColor = .nftBlack
        return label
    }()
    
    private lazy var recycleButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "trash.fill"), for: .normal)
        button.tintColor = .nftRedUni
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setRacnk() {
        switch rank {
        case .one:
            starImage1.tintColor = .nftYellowUni
        case .two:
            starImage1.tintColor = .nftYellowUni
            starImage2.tintColor = .nftYellowUni
        case .three:
            starImage1.tintColor = .nftYellowUni
            starImage2.tintColor = .nftYellowUni
            starImage3.tintColor = .nftYellowUni
        case .four:
            starImage1.tintColor = .nftYellowUni
            starImage2.tintColor = .nftYellowUni
            starImage3.tintColor = .nftYellowUni
            starImage4.tintColor = .nftYellowUni
        case .five:
            starImage1.tintColor = .nftYellowUni
            starImage2.tintColor = .nftYellowUni
            starImage3.tintColor = .nftYellowUni
            starImage4.tintColor = .nftYellowUni
            starImage5.tintColor = .nftYellowUni
        case .zero:
            starImage1.tintColor = .nftLightGrey
            starImage2.tintColor = .nftLightGrey
            starImage3.tintColor = .nftLightGrey
            starImage4.tintColor = .nftLightGrey
            starImage5.tintColor = .nftLightGrey
        case .none:
            starImage1.tintColor = .nftLightGrey
            starImage2.tintColor = .nftLightGrey
            starImage3.tintColor = .nftLightGrey
            starImage4.tintColor = .nftLightGrey
            starImage5.tintColor = .nftLightGrey
        }
    }
    
    rank?.rawValue = 1
    
    func setupView() {
        [itemImageView, hStack, itmeTitle, priceLable, recycleButton].forEach { subView in
            contentView.addSubview(subView)
        }
    }
    
    func addConstraints() {
        
    }
    
}
