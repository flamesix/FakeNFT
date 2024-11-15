import UIKit
import SnapKit

protocol StatisticsViewControllerProtocol: AnyObject, LoadingView, ErrorView {
    var presenter: StatisticsPresenterProtocol? { get set }
    func updateTableView()
}

final class StatisticsViewController: UIViewController, StatisticsViewControllerProtocol {
    
    // MARK: - Properties
    var presenter: StatisticsPresenterProtocol?
    
    let servicesAssembly: ServicesAssembly
    
    internal lazy var activityIndicator = UIActivityIndicatorView()
    
    // MARK: - Init
    init(servicesAssembly: ServicesAssembly) {
        self.servicesAssembly = servicesAssembly
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIElements
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .nftWhite
        tableView.register(StatisticsTableViewCell.self)
        return tableView
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.viewDidLoad()
    }
    
    // MARK: - Methods
    @objc private func didTapFilterButton() {
        let alertController = UIAlertController(title: NSLocalizedString("Statistics.Sort", comment: ""), message: nil, preferredStyle: .actionSheet)
        
        let byNameAction = UIAlertAction(title: NSLocalizedString("Statistics.ByName", comment: ""), style: .default) { [weak self] _ in
            self?.presenter?.filter(by: .name)
            self?.tableView.reloadData()
            
        }
        
        let byRatingAction = UIAlertAction(title: NSLocalizedString("Statistics.ByRating", comment: ""), style: .default) { [weak self] _ in
            self?.presenter?.filter(by: .rating)
            self?.tableView.reloadData()
        }
        
        let closeAction = UIAlertAction(title: NSLocalizedString("Statistics.Close", comment: ""), style: .cancel)
        
        [byNameAction, byRatingAction, closeAction].forEach {
            alertController.addAction($0)
        }
        
        present(alertController, animated: true)
    }
    
    func updateTableView() {
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension StatisticsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.filteredUsers.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: StatisticsTableViewCell = tableView.dequeueReusableCell()
        guard let user = presenter?.filteredUsers[indexPath.row] else { return cell }
        cell.configure(with: user)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension StatisticsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        88
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let user = presenter?.filteredUsers[indexPath.row] else { return }
        let vc = UserCardViewController()
        let presenter = UserCardPresenter(user: user)
        vc.presenter = presenter
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        presenter?.willDisplay(for: indexPath)
    }
}

// MARK: - SettingView
extension StatisticsViewController: SettingViewsProtocol {
    func setupView() {
        view.backgroundColor = .nftWhite
        view.addSubviews(tableView, activityIndicator)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "sortIcon"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(didTapFilterButton))
        navigationItem.rightBarButtonItem?.tintColor = .nftBlack
        
        addConstraints()
    }
    
    func addConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(20)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(8)
        }
        
        activityIndicator.snp.makeConstraints { $0.center.equalToSuperview() }
    }
}
