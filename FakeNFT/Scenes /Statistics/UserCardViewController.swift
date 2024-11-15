import UIKit
import SnapKit
import Kingfisher

protocol UserCardViewControllerProtocol: AnyObject {
    var presenter: UserCardPresenterProtocol? { get set }
    func configureUI(with user: User)
}

final class UserCardViewController: UIViewController, UserCardViewControllerProtocol {
    
    var presenter: UserCardPresenterProtocol?
    
    // MARK: - UIElements
    private lazy var profileImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 35
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .bold22
        label.textColor = .nftBlack
        return label
    }()
    
    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [profileImage, nameLabel])
        stackView.axis = .horizontal
        stackView.spacing = 16
        return stackView
    }()
    
    private lazy var bioLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineHeight = 18
        label.font = .regular13
        label.textColor = .nftBlack
        return label
    }()
    
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [horizontalStackView, bioLabel])
        stackView.axis = .vertical
        stackView.spacing = 20
        return stackView
    }()
    
    private lazy var webPageButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .nftWhite
        button.layer.cornerRadius = 16
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.nftBlack.cgColor
        button.titleLabel?.font = .regular15
        button.setTitle(NSLocalizedString("Statistics.GoToWeb", comment: ""), for: .normal)
        button.setTitleColor(.nftBlack, for: .normal)
        return button
    }()
    
    private lazy var nftButton = NftButton()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.viewDidLoad()
    }
    
    @objc private func didTapNftButton() {
        print("didTapNftButton")
    }
    
    @objc private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    func configureUI(with user: User) {
        setProfileImage(for: user)
        nameLabel.text = user.name
        bioLabel.text = user.description
        nftButton.setupTitle(user.nfts.count)
    }
    
    private func setProfileImage(for user: User) {
        let url = URL(string: user.avatar)
        profileImage.kf.indicatorType = .activity
        profileImage.kf.setImage(with: url, placeholder: UIImage(named: "avatarPlaceholder")) { [weak self] result in
            switch result {
            case .success(let image):
                self?.profileImage.image = image.image
            case .failure(_):
                self?.profileImage.image = UIImage(named: "avatarPlaceholder")
            }
        }
    }
}

// MARK: - SettingView
extension UserCardViewController: SettingViewsProtocol {
    func setupView() {
        presenter?.view = self
        view.backgroundColor = .nftWhite
        view.addSubviews(verticalStackView, webPageButton, nftButton)
        
        addConstraints()
        setupNavigationBar()
        
        nftButton.addTarget(self, action: #selector(didTapNftButton), for: .touchUpInside)
    }
    
    func addConstraints() {
        
        profileImage.snp.makeConstraints { $0.width.height.equalTo(70) }
        
        verticalStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(16)
        }
        
        webPageButton.snp.makeConstraints { make in
            make.top.equalTo(verticalStackView.snp.bottom).offset(28)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
        
        nftButton.snp.makeConstraints { make in
            make.top.equalTo(webPageButton.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(54)
        }
    }

    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(didTapBackButton))
        navigationItem.leftBarButtonItem?.tintColor = .nftBlack
    }
}
