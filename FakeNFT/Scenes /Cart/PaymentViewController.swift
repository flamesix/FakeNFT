//
//  PaymentViewController.swift
//  FakeNFT
//
//  Created by Pavel Bobkov on 16.11.2024.
//

import UIKit

protocol PaymentViewProtocol: AnyObject {
    
}

final class PaymentViewController: UIViewController, PaymentViewProtocol {
    
    // MARK: - Properties
    
    private let presenter: PaymentPresenterProtocol
    
    // MARK: - Init
    
    init(presenter: PaymentPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
