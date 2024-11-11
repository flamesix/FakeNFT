import UIKit

final class NftMainCollectionController: UIViewController {

    let servicesAssembly: ServicesAssembly

    init(servicesAssembly: ServicesAssembly) {
        self.servicesAssembly = servicesAssembly
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .systemBackground
        let assembly = NftCollectionCatalogueAssembly(servicesAssembler: servicesAssembly)
        let nftViewController = assembly.build()
        present(nftViewController, animated: true)
        showNftCatalogue()
    }

    func showNftCatalogue() {

    }
}

