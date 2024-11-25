
import UIKit

// MARK: - Protocol

protocol NftCollectionsCatalgueViewContollerProtocol: AnyObject, ErrorView, LoadingView {
    func displayCatalogue(_ collectionCatalogue: [Catalogue], _ cataloguesPerPage: Int)
}

enum SortedBy {
    case name, nftCount
}

final class NftCollectionsCatalgueViewContoller: UIViewController, SettingViewsProtocol {
    
    private let presenter: NftCatalogueDetailPresenter
    private let servicesAssembly: ServicesAssembly
    private let nftCollectionSortAlerPresenter = NftCollectionSortAlerPresenter()
    private var collectionCatalogue: [Catalogue] = []
    private var collectionCatalogueAfterUpdate: [Catalogue] = []
    private var sortedCollectionCatalogue: [Catalogue] = []
    private var cataloguesPerPage: Int = 5
    
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

    init(presenter: NftCatalogueDetailPresenter, serviceAsssembly: ServicesAssembly) {
        self.presenter = presenter
        self.servicesAssembly = serviceAsssembly
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nftCollectionSortAlerPresenter.delegate = self
        setupView()
        addConstraints()
        presenter.viewDidLoad()
    }
    
    @objc func sortCatalogues(){
        nftCollectionSortAlerPresenter.showSortAlert(on: self)
    }
    
    func setupView() {
        view.addSubviews(nftCollectionsTableView, nftCollectionsSort)
        view.backgroundColor = .nftWhite
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
    func addNewRows(){
        nftCollectionsTableView.performBatchUpdates {
            
            let insertStartIndex = collectionCatalogueAfterUpdate.count
            let insertStopIndex = collectionCatalogue.count
            
            var indexPaths: [IndexPath] = []
            for row in insertStartIndex..<insertStopIndex {
                indexPaths.append(IndexPath(row: row, section: 0))
            }
            nftCollectionsTableView.insertRows(at: indexPaths, with: .automatic)
            collectionCatalogueAfterUpdate = collectionCatalogue
        }
    }
    
    func updateTableView(){
        nftCollectionsTableView.performBatchUpdates {
            
            let indexes: [Int] = Array(0..<sortedCollectionCatalogue.count)
            var updatedIndexes: [Int] = indexes
            
            for index in 0..<sortedCollectionCatalogue.count {
                if sortedCollectionCatalogue[index].id == collectionCatalogue[index].id {
                    updatedIndexes.removeAll { removedIndex in
                        index == removedIndex
                    }
                }
            }
            
            let indexPaths = updatedIndexes.map { index in
                IndexPath(row: index, section: 0)
            }
            
            if !updatedIndexes.isEmpty {
                nftCollectionsTableView.deleteRows(at: indexPaths, with: .automatic)
                nftCollectionsTableView.insertRows(at: indexPaths, with: .automatic)
            }
            collectionCatalogue = sortedCollectionCatalogue
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.row + 1) % cataloguesPerPage == 0, indexPath.row == collectionCatalogue.count - 1 {
            presenter.viewDidLoad()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collectionCatalogue.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "collection cell", for: indexPath) as? NftCollectionTableViewCell else { return UITableViewCell()}
        cell.configure(with: collectionCatalogue[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
}

extension NftCollectionsCatalgueViewContoller: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let catalogue = collectionCatalogue[indexPath.row]
        let presenter = NftCatalogueItemPresenter(input: catalogue.nfts, servicesAssembly: servicesAssembly)
        let viewController = NftCatalogueItemViewController(serviceAssembly: servicesAssembly, presenter: presenter, catalogue: catalogue)
        presenter.view = viewController
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true)
    }
}

extension NftCollectionsCatalgueViewContoller: NftCollectionsCatalgueViewContollerProtocol {

    func displayCatalogue(_ collectionCatalogue: [Catalogue], _ cataloguesPerPage: Int) {
        self.collectionCatalogue += collectionCatalogue
        self.cataloguesPerPage = cataloguesPerPage
        self.catalogueUpdate(with: collectionSortState)
    }
}

extension NftCollectionsCatalgueViewContoller: NftCollectionSortProtocol {

    func catalogueUpdate(with sortState: SortedBy?){
        
        if let sortState = sortState {
            collectionSortState = sortState
        }
        switch collectionSortState {
        case .name:
            self.sortedCollectionCatalogue = self.collectionCatalogue.sorted(by: { catalogue1, catalogue2 in
                catalogue1.name < catalogue2.name
            })
        case .nftCount:
            self.sortedCollectionCatalogue = self.collectionCatalogue.sorted(by: { catalogue1, catalogue2 in
                catalogue1.nfts.count > catalogue2.nfts.count
            })
        }
        addNewRows()
        updateTableView()
    }
}
