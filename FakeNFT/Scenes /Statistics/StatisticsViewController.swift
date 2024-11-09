//
//  StatisticsViewController.swift
//  FakeNFT
//
//  Created by Юрий Гриневич on 09.11.2024.
//

import UIKit
import SnapKit

protocol StatisticsViewControllerProtocol: AnyObject {
    var presenter: StatisticsPresenterProtocol? { get set }
}

final class StatisticsViewController: UIViewController, StatisticsViewControllerProtocol {
    
    var presenter: StatisticsPresenterProtocol?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(StatisticsTableViewCell.self)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

extension StatisticsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: StatisticsTableViewCell = tableView.dequeueReusableCell()
        cell.configure()
        return cell
    }
}

extension StatisticsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        88
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension StatisticsViewController: SettingViewsProtocol {
    func setupView() {
        view.backgroundColor = .nftWhite
        view.addSubviews(tableView)
        
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
