import Foundation

protocol StatisticsPresenterProtocol {
    var view: StatisticsViewControllerProtocol? { get set }
}

final class StatisticsPresenter: StatisticsPresenterProtocol {
    
    weak var view: StatisticsViewControllerProtocol?
    
    
}
