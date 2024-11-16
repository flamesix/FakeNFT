import UIKit
import SnapKit

protocol NftCollectionViewControllerProtocol: AnyObject {
    var presenter: NftCollectionPresenter? { get set }
}

final class NftCollectionViewController: UIViewController, NftCollectionViewControllerProtocol {
    
    var presenter: NftCollectionPresenter?
    
    lazy var activityIndicator = UIActivityIndicatorView()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .nftWhite
        collectionView.register(NftCollectionCollectionViewCell.self)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.viewDidLoad()
    }
    
}

extension NftCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    
}

extension NftCollectionViewController: UICollectionViewDelegateFlowLayout {
    
}

extension NftCollectionViewController: SettingViewsProtocol {
    func setupView() {
        title = NSLocalizedString("UserCard.NFTCollection.Count", comment: "")
        view.backgroundColor = .nftWhite
        view.addSubviews(collectionView)
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
