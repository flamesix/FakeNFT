import UIKit
import SnapKit

protocol NftCollectionViewControllerProtocol: AnyObject, LoadingView, ErrorView {
    var presenter: NftCollectionPresenterProtocol? { get set }
    func updateCollectionView()
}

final class NftCollectionViewController: UIViewController, NftCollectionViewControllerProtocol {
    
    var presenter: NftCollectionPresenterProtocol?
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
    
    // MARK: - Methods
    @objc private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    func updateCollectionView() {
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource
extension NftCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter?.getNftCount() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: NftCollectionCollectionViewCell = collectionView.dequeueReusableCell(indexPath: indexPath)
        cell.delegate = self
        guard let presenter else { return UICollectionViewCell() }
        let nft = presenter.getNft(indexPath.row)
        let isLiked = presenter.isLiked(indexPath.row)
        let isOrdered = presenter.isOrdered(indexPath.row)
        cell.config(with: nft, isLiked: isLiked, isOrdered: isOrdered)
        return cell
    }
}

// MARK: - NftCollectionCollectionViewCellDelegate
extension NftCollectionViewController: NftCollectionCollectionViewCellDelegate {
    func tapLike(_ id: String, _ cell: NftCollectionCollectionViewCell) {
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        presenter?.tapLike(id, indexPath)
    }
    
    func tapCart(_ id: String, _ cell: NftCollectionCollectionViewCell) {
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        presenter?.tapCart(id, indexPath)
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
        setupNavigationBar()
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
    
    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(didTapBackButton))
        navigationItem.leftBarButtonItem?.tintColor = .nftBlack
    }
}
