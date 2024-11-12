import UIKit

final class NftCatalogueItemCollectionViewCell: UICollectionViewCell, SettingViewsProtocol {

    private var rank: Int?
    
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
        return stack
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
        button.setImage(UIImage(resource: .nftRecycleEmpty), for: .normal)
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
        case 1:
            starImage1.tintColor = .nftYellowUni
        case 2:
            starImage1.tintColor = .nftYellowUni
            starImage2.tintColor = .nftYellowUni
        case 3:
            starImage1.tintColor = .nftYellowUni
            starImage2.tintColor = .nftYellowUni
            starImage3.tintColor = .nftYellowUni
        case 4:
            starImage1.tintColor = .nftYellowUni
            starImage2.tintColor = .nftYellowUni
            starImage3.tintColor = .nftYellowUni
            starImage4.tintColor = .nftYellowUni
        case 5:
            starImage1.tintColor = .nftYellowUni
            starImage2.tintColor = .nftYellowUni
            starImage3.tintColor = .nftYellowUni
            starImage4.tintColor = .nftYellowUni
            starImage5.tintColor = .nftYellowUni
        default:
            starImage1.tintColor = .nftLightGrey
            starImage2.tintColor = .nftLightGrey
            starImage3.tintColor = .nftLightGrey
            starImage4.tintColor = .nftLightGrey
            starImage5.tintColor = .nftLightGrey
        }
    }
    
    func configureItem(with item: NftCollectionItem) {
        
    }
    
    func setupView() {
        [itemImageView, hStack, itmeTitle, priceLable, recycleButton].forEach { subView in
            contentView.addSubview(subView)
        }
    }
    
    func addConstraints() {
        itemImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView)
            make.leading.equalTo(contentView)
            make.trailing.equalTo(contentView)
            make.height.equalTo(108)
            make.width.equalTo(108)
        }
        
        likeImageView.snp.makeConstraints { make in
            make.top.equalTo(itemImageView.snp.top)
            make.trailing.equalTo(itemImageView.snp.trailing)
            make.height.equalTo(42)
            make.width.equalTo(42)
        }
        
        hStack.snp.makeConstraints { make in
            make.top.equalTo(itemImageView.snp.bottom).offset(8)
            make.leading.equalTo(itemImageView.snp.leading)
            make.height.equalTo(12)
            make.width.equalTo(68)
        }
        
        itmeTitle.snp.makeConstraints { make in
            make.top.equalTo(hStack.snp.bottom).offset(5)
            make.leading.equalTo(itemImageView.snp.leading)
        }
        
        priceLable.snp.makeConstraints { make in
            make.top.equalTo(itmeTitle.snp.bottom).offset(4)
            make.leading.equalTo(itemImageView.snp.leading)
        }
        
        recycleButton.snp.makeConstraints { make in
            make.top.equalTo(itemImageView.snp.bottom).offset(24)
            make.trailing.equalTo(itemImageView.snp.trailing)
            make.height.equalTo(40)
            make.width.equalTo(40)
        }
    }
    
}
