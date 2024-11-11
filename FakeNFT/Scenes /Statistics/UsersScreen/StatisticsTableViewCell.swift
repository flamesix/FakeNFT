import UIKit
import SnapKit
import Kingfisher

final class StatisticsTableViewCell: UITableViewCell, ReuseIdentifying {
    
    // MARK: - UIElements
    private lazy var backgroundGreyView: UIView = {
        let view = UIView()
        view.backgroundColor = .nftLightGrey
        view.layer.cornerRadius = 12
        return view
    }()
    
    private lazy var mainStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [ratingLabel, backgroundGreyView])
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.font = .regular15
        label.textAlignment = .center
        label.textColor = .nftBlack
        return label
    }()
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 14
        return imageView
    }()
    
    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.font = .bold22
        label.textColor = .nftBlack
        label.contentCompressionResistancePriority(for: .horizontal)
        return label
    }()
    
    private lazy var nftCountLabel: UILabel = {
        let label = UILabel()
        label.font = .bold22
        label.textColor = .nftBlack
        return label
    }()
    
    // MARK: - LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - PublicMethods
    func configure(with user: User) {
        ratingLabel.text = user.rating
        usernameLabel.text = user.name
        nftCountLabel.text = user.nfts.count.description
        setAvatarImage(for: user)
    }
    
    private func setAvatarImage(for user: User) {
        let url = URL(string: user.avatar)
        avatarImageView.kf.indicatorType = .activity
        avatarImageView.kf.setImage(with: url, placeholder: UIImage(named: "avatarPlaceholder")) { [weak self] result in
            switch result {
            case .success(let image):
                self?.avatarImageView.image = image.image
            case .failure(let error):
                // TODO: Error handling
                self?.avatarImageView.image = UIImage(named: "avatarPlaceholder")
            }
        }
    }
}

// MARK: - SettingView
extension StatisticsTableViewCell: SettingViewsProtocol {
    func setupView() {
        backgroundColor = .clear
        selectionStyle = .none
        addSubviews(mainStack)
        backgroundGreyView.addSubviews(avatarImageView, usernameLabel, nftCountLabel)
        
        addConstraints()
    }
    
    func addConstraints() {
        let spacing = UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0)
        mainStack.snp.makeConstraints { $0.edges.equalToSuperview().inset(spacing) }
        
        ratingLabel.snp.makeConstraints { make in
            make.width.equalTo(28)
        }
        
        avatarImageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(26)
            make.leading.equalToSuperview().inset(16)
            make.height.width.equalTo(28)
        }
        
        usernameLabel.snp.makeConstraints { make in
            make.leading.equalTo(avatarImageView.snp.trailing).offset(8)
            make.trailing.equalToSuperview().inset(70)
            make.top.bottom.equalToSuperview().inset(26)
        }
        
        nftCountLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(26)
            make.trailing.equalToSuperview().inset(16)
        }
    }
}
