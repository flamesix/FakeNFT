import UIKit
import SnapKit

final class NftButton: UIButton {
    
    // MARK: - UIElements
    private lazy var title = {
        let label = UILabel()
        label.textColor = .nftBlack
        label.font = .bold17
        return label
    }()
    
    private lazy var chevron: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "chevron.right"))
        image.tintColor = .nftBlack
        return image
    }()
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupTitle(_ title: String) {
        self.title.text = title
    }
}

// MARK: - SettingView
extension NftButton: SettingViewsProtocol {
    func setupView() {
        addSubviews(title, chevron)
        addConstraints()
    }
    
    func addConstraints() {
        title.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(16)
            make.leading.equalToSuperview()
        }
        
        chevron.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(16)
            make.trailing.equalToSuperview()
        }
    }
}
