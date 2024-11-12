//
//  CartViewController.swift
//  FakeNFT
//
//  Created by Pavel Bobkov on 12.11.2024.
//

import UIKit

protocol CartViewProtocol: AnyObject {
    
}

final class CartViewController: UIViewController {
    
    private let presenter: CartPresenterProtocol
    
    // MARK: - Init

    init(presenter: CartPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Functions

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
    }
    
}

extension CartViewController: CartViewProtocol {
    
}
