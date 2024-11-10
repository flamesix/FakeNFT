import UIKit
import SnapKit

protocol UserCardViewControllerProtocol: AnyObject {
    var presenter: UserCardPresenterProtocol? { get set }
}

final class UserCardViewController: UIViewController, UserCardViewControllerProtocol {
    
    var presenter: UserCardPresenterProtocol?
    
    // MARK: - UIElements
    private lazy var profileImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 35
        image.clipsToBounds = true
        image.image = UIImage(named: "profilePhoto")
        return image
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Joaquin Phoenix"
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
        label.text = "Hello, world!"
        label.numberOfLines = 0
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
    }
    
    @objc private func didTapNftButton() {
        print("didTapNftButton")
    }
}

// MARK: - SettingView
extension UserCardViewController: SettingViewsProtocol {
    func setupView() {
        presenter?.view = self
        view.backgroundColor = .nftWhite
        view.addSubviews(verticalStackView, webPageButton, nftButton)
        
        addConstraints()
        
        nftButton.addTarget(self, action: #selector(didTapNftButton), for: .touchUpInside)
        nftButton.setupTitle("Коллекция NFT (112)")
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
}
