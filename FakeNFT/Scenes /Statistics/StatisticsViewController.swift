import UIKit
import SnapKit

protocol StatisticsViewControllerProtocol: AnyObject {
    var presenter: StatisticsPresenterProtocol? { get set }
}

final class StatisticsViewController: UIViewController, StatisticsViewControllerProtocol {
    
    var presenter: StatisticsPresenterProtocol?
    
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
    }
    
    @objc private func didTapFilterButton() {
        let alertController = UIAlertController(title: NSLocalizedString("Statistics.Sort", comment: ""), message: nil, preferredStyle: .actionSheet)
        
        let byNameAction = UIAlertAction(title: NSLocalizedString("Statistics.ByName", comment: ""), style: .default) { [weak self] _ in
            print("Sort by name")
            
        }
        
        let byRatingAction = UIAlertAction(title: NSLocalizedString("Statistics.ByRating", comment: ""), style: .default) { [weak self] _ in
            print("Sort by rating")
        }
        
        let closeAction = UIAlertAction(title: NSLocalizedString("Statistics.Close", comment: ""), style: .cancel)
        
        [byNameAction, byRatingAction, closeAction].forEach {
            alertController.addAction($0)
        }
        
        present(alertController, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension StatisticsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.users.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: StatisticsTableViewCell = tableView.dequeueReusableCell()
        guard let user = presenter?.users[indexPath.row] else { return cell }
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
    }
}

// MARK: - SettingView
extension StatisticsViewController: SettingViewsProtocol {
    func setupView() {
        presenter?.view = self
        self.presenter = StatisticsPresenter()
        view.backgroundColor = .nftWhite
        view.addSubviews(tableView)
        
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
    }
}
