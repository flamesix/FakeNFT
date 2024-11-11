import UIKit

public final class StatisticsAssembly {

    private let servicesAssembler: ServicesAssembly

    init(servicesAssembler: ServicesAssembly) {
        self.servicesAssembler = servicesAssembler
    }

    public func build() -> UINavigationController {
        let presenter = StatisticsPresenter(service: servicesAssembler.statisticService)
        let viewController = StatisticsViewController(servicesAssembly: servicesAssembler)
        presenter.view = viewController
        viewController.presenter = presenter
        return UINavigationController(rootViewController: viewController)
    }
}
