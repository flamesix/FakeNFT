import UIKit
import SnapKit

protocol NftCollectionViewControllerProtocol: AnyObject, LoadingView, ErrorView {
    var presenter: NftCollectionPresenter? { get set }
}

final class NftCollectionViewController: UIViewController, NftCollectionViewControllerProtocol {
    
    var presenter: NftCollectionPresenter?
    let servicesAssembly: ServicesAssembly
    
    // MARK: - UIElements
    lazy var activityIndicator = UIActivityIndicatorView()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .nftWhite
        collectionView.register(NftCollectionCollectionViewCell.self)
        return collectionView
    }()
    
    // MARK: - Init
    init(servicesAssembly: ServicesAssembly) {
        self.servicesAssembly = servicesAssembly
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.viewDidLoad()
    }
    
}

// MARK: - UICollectionViewDataSource
extension NftCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter?.getNftCount() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: NftCollectionCollectionViewCell = collectionView.dequeueReusableCell(indexPath: indexPath)
        guard let nft = presenter?.getNft(indexPath.row) else { return UICollectionViewCell() }
        cell.config(with: nft)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension NftCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 9
        let width = (collectionView.bounds.width - 2 * spacing) / 3
        let height: CGFloat = width * 1.6
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 28
    }
}

// MARK: - SettingView
extension NftCollectionViewController: SettingViewsProtocol {
    func setupView() {
        title = NSLocalizedString("UserCard.NFTCollection.Count", comment: "")
        view.backgroundColor = .nftWhite
        view.addSubviews(collectionView, activityIndicator)
        collectionView.delegate = self
        collectionView.dataSource = self
        addConstraints()
    }
    
    func addConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(20)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(8)
        }
        
        activityIndicator.snp.makeConstraints { $0.center.equalToSuperview() }
    }
}
