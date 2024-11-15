import UIKit

final class UserCardAssembly {

    private let user: User

    init(user: User) {
        self.user = user
    }

    func build() -> UIViewController {
        let presenter = UserCardPresenter(user: user)
        let viewController = UserCardViewController()
        presenter.view = viewController
        viewController.presenter = presenter
        return viewController
    }
}
