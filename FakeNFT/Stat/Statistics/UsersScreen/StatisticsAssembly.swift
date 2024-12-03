import UIKit

final class StatisticsAssembly {

    private let servicesAssembler: ServicesAssembly

    init(servicesAssembler: ServicesAssembly) {
        self.servicesAssembler = servicesAssembler
    }

    func build() -> UINavigationController {
        let presenter = StatisticsPresenter(service: servicesAssembler.statisticService)
        let viewController = StatisticsViewController(servicesAssembly: servicesAssembler)
        presenter.view = viewController
        viewController.presenter = presenter
        return UINavigationController(rootViewController: viewController)
    }
}
