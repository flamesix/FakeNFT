//
//  StatisticsPresenter.swift
//  FakeNFT
//
//  Created by Юрий Гриневич on 09.11.2024.
//

import Foundation

protocol StatisticsPresenterProtocol {
    var view: StatisticsViewControllerProtocol? { get set }
}

final class StatisticsPresenter: StatisticsPresenterProtocol {
    
    weak var view: StatisticsViewControllerProtocol?
    
    
}
