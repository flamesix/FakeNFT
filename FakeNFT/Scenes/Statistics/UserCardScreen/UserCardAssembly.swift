import UIKit

final class UserCardAssembly {

    private let user: User
    private let servicesAssembler: ServicesAssembly

    init(user: User, servicesAssembler: ServicesAssembly) {
        self.user = user
        self.servicesAssembler = servicesAssembler
    }

    func build() -> UIViewController {
        let presenter = UserCardPresenter(user: user)
        let viewController = UserCardViewController(servicesAssembly: servicesAssembler)
        presenter.view = viewController
        viewController.presenter = presenter
        viewController.hidesBottomBarWhenPushed = true
        return viewController
    }
}
