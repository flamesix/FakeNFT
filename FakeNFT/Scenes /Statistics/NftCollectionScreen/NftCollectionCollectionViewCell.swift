import UIKit
import SnapKit
import Cosmos
import Kingfisher

protocol NftCollectionCollectionViewCellDelegate: AnyObject {
    func tapLike(_ id: String, _ cell: NftCollectionCollectionViewCell)
    func tapCart(_ id: String, _ cell: NftCollectionCollectionViewCell)
}

final class NftCollectionCollectionViewCell: UICollectionViewCell, ReuseIdentifying {
    
    var delegate: NftCollectionCollectionViewCellDelegate?
    private var id: String?
    private var isLiked: Bool = false
    private var isCarted: Bool = false
    
    // MARK: - UIElements
    private lazy var nftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .bold17
        label.backgroundColor = .clear
        label.textColor = .nftBlack
        return label
    }()
    
    private lazy var ratingView: CosmosView = {
        let view = CosmosView()
        view.settings.filledColor = .nftYellowUni
        view.settings.emptyColor = .nftLightGrey
        view.settings.filledBorderWidth = 0
        view.settings.emptyBorderWidth = 0
        view.settings.starSize = 12
        view.settings.starMargin = 2
        view.rating = 4
        return view
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = .medium10
        label.textColor = .nftBlack
        return label
    }()
    
    private lazy var subLikeView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        button.addTarget(self, action: #selector(didTapLikeButton), for: .touchUpInside)
        button.tintColor = .nftWhiteUni
        return button
    }()
    
    private lazy var subCartView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var cartButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "addToCart"), for: .normal)
        button.addTarget(self, action: #selector(didTapCartButton), for: .touchUpInside)
        button.tintColor = .nftBlack
        return button
    }()
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(with nft: Nft, isLiked: Bool, isOrdered: Bool) {
        self.id = nft.id
        self.isLiked = isLiked
        self.isCarted = isOrdered
        nameLabel.text = nft.name
        ratingView.rating = Double(nft.rating)
        priceLabel.text = String(nft.price) + " ETH"
        setNftImage(for: nft)
        likeButton.tintColor = isLiked ? .nftRedUni : .nftWhiteUni
        cartButton.setImage(UIImage(named: isOrdered ? "removeFromCart" : "addToCart"), for: .normal)
    }
    
    private func setNftImage(for nft: Nft) {
        let url = nft.images[0]
        nftImageView.kf.indicatorType = .activity
        nftImageView.kf.setImage(with: url)
    }
    
    @objc private func didTapLikeButton() {
        guard let id else { return }
        isLiked.toggle()
        likeButton.tintColor = isLiked ? .nftRedUni : .nftWhiteUni
        delegate?.tapLike(id, self)
    }
    
    @objc private func didTapCartButton() {
        guard let id else { return }
        isCarted.toggle()
        cartButton.setImage(UIImage(named: isCarted ? "removeFromCart" : "addToCart"), for: .normal)
        delegate?.tapCart(id, self)
    }
}

// MARK: - SettingView
extension NftCollectionCollectionViewCell: SettingViewsProtocol {
    func setupView() {
        layer.cornerRadius = 12
        addSubviews(nftImageView, ratingView, nameLabel, priceLabel, subLikeView, subCartView)
        subCartView.addSubviews(cartButton)
        subLikeView.addSubviews(likeButton)
        addConstraints()
    }
    
    func addConstraints() {
        
        nftImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(nftImageView.snp.width)
        }
        
        subLikeView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(40)
        }
        
        ratingView.snp.makeConstraints { make in
            make.top.equalTo(nftImageView.snp.bottom).offset(8)
            make.leading.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.63)
            make.height.equalTo(12)
        }
        

        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(ratingView.snp.bottom).offset(4)
            make.leading.equalToSuperview()
            make.width.equalTo(ratingView.snp.width)
            make.height.equalTo(subCartView.snp.height).multipliedBy(0.55)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.bottom.equalTo(subCartView.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalTo(subCartView.snp.leading)
            make.height.equalTo(subCartView.snp.height).multipliedBy(0.3)
        }
        
        subCartView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.top)
            make.leading.equalTo(nameLabel.snp.trailing)
            make.trailing.equalToSuperview()
            make.height.equalTo(subCartView.snp.width)
        }
        
        likeButton.snp.makeConstraints { $0.center.equalToSuperview() }
        cartButton.snp.makeConstraints { $0.center.equalToSuperview() }
    }
}
