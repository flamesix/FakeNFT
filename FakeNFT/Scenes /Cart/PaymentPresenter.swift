//
//  PaymentPresenter.swift
//  FakeNFT
//
//  Created by Pavel Bobkov on 16.11.2024.
//

import Foundation

protocol PaymentPresenterProtocol {
    
}

final class PaymentPresenter: PaymentPresenterProtocol {
    
    // MARK: - Properties
    
    weak var view: PaymentViewProtocol?
    private let paymentService: PaymentServiceProtocol
    
    // MARK: - Init
    
    init(paymentService: PaymentServiceProtocol) {
        self.paymentService = paymentService
    }
}
