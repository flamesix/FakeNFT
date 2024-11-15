
import UIKit

protocol NftCollectionsCatalgueViewContollerProtocol: AnyObject, ErrorView, LoadingView {
    func displayCatalogue(_ collectionCatalogue: [NftCatalogueCollection], _ cataloguesPerPage: Int)
}

enum SortedBy {
    case name, nftCount
}

final class NftCollectionsCatalgueViewContoller: UIViewController, SettingViewsProtocol {
    
    private let presenter: NftCatalogueDetailPresenter
    private let servicesAssembly: CatalogueServicesAssembly
    private var collectionCatalogue: [NftCatalogueCollection] = []
    private var cataloguesPerPage: Int = 5
    private var nftCollectionCatalogueFactory = NftCollectionCatalogueFactory()
    
    private lazy var nftCollectionsSort: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(resource: .nftCatalogueSort)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(sortCatalogues), for: .touchUpInside)
        button.tintColor = .nftBlack
        return button
    }()

    private lazy var nftCollectionsTableView: CatalogueCollectionTableView = {
        let tableView = CatalogueCollectionTableView()
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    private var collectionSortState: SortedBy = .nftCount

    init(presenter: NftCatalogueDetailPresenter, serviceAsssembly: CatalogueServicesAssembly) {
        self.presenter = presenter
        self.servicesAssembly = serviceAsssembly
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupView()
        addConstraints()
        presenter.viewDidLoad()
    }
    
    @objc func sortCatalogues(){
        let alert = UIAlertController(title: "Сртировка", message: nil, preferredStyle: .actionSheet)
        let sortByCount = UIAlertAction(title: "По количеству NFT", style: .default) { _ in
            self.collectionSortState = .nftCount
            self.catalogueUpdate()
        }
        let sortByName = UIAlertAction(title: "По названию", style: .default) { _ in
            self.collectionSortState = .name
            self.catalogueUpdate()
        }
        let cancel = UIAlertAction(title: "Закрыть", style: .cancel)
        alert.addAction(sortByName)
        alert.addAction(sortByCount)
        alert.addAction(cancel)
        self.present(alert, animated: true)
    }
    
    func catalogueUpdate(){
        switch collectionSortState {
        case .name:
            self.collectionCatalogue = self.collectionCatalogue.sorted(by: { catalogue1, catalogue2 in
                catalogue1.name < catalogue2.name
            })
        case .nftCount:
            self.collectionCatalogue = self.collectionCatalogue.sorted(by: { catalogue1, catalogue2 in
                catalogue1.nfts.count > catalogue2.nfts.count
            })
        }
        nftCollectionsTableView.reloadData()
    }
    
    func setupView() {
        [nftCollectionsTableView, nftCollectionsSort].forEach {view.addSubview($0)
        }
    }
    
    func addConstraints() {
        
        nftCollectionsSort.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(46)
            make.right.equalToSuperview().offset(-9)
            make.height.equalTo(42)
            make.width.equalTo(42)
        }
        
        nftCollectionsTableView.snp.makeConstraints { make in
            make.top.equalTo(nftCollectionsSort.snp.bottom).offset(16)
            make.left.equalTo(view).offset(16)
            make.right.equalTo(view).offset(-16)
            make.bottom.equalToSuperview()
        }
    }
}

extension NftCollectionsCatalgueViewContoller: UITableViewDataSource {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.row + 1) % cataloguesPerPage == 0, indexPath.row == collectionCatalogue.count - 1 {
            presenter.viewDidLoad()
        }
        print(collectionCatalogue.count)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collectionCatalogue.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "collection cell", for: indexPath) as! NftCollectionTableViewCell
        cell.configure(with: collectionCatalogue[indexPath.row])
        return cell
    }
}

extension NftCollectionsCatalgueViewContoller: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let catalogue = collectionCatalogue[indexPath.row]
        let presenter = NftCatalogueItemPresenter(input: catalogue.nfts, service: servicesAssembly.nftItemsService)
        let viewController = NftCatalogueItemViewController(presenter: presenter, catalogue: catalogue)
        presenter.view = viewController
//        let navigationController = UINavigationController(rootViewController: viewController)
//        navigationController.modalPresentationStyle = .fullScreen
//        self.present(navigationController, animated: true)
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true)
    }
}

extension NftCollectionsCatalgueViewContoller: NftCollectionsCatalgueViewContollerProtocol {

    func displayCatalogue(_ collectionCatalogue: [NftCatalogueCollection], _ cataloguesPerPage: Int) {
        self.collectionCatalogue += collectionCatalogue
        self.cataloguesPerPage = cataloguesPerPage
        self.catalogueUpdate()
    }
}
