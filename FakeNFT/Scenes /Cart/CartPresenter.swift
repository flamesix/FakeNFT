//
//  CartPresenter.swift
//  FakeNFT
//
//  Created by Pavel Bobkov on 12.11.2024.
//

protocol CartPresenterProtocol {
    
}

final class CartPresenter: CartPresenterProtocol {
    
    // MARK: - Properties

    weak var view: CartViewProtocol?
    private let service: NftService
    
    // MARK: - Init

    init(service: NftService) {
        self.service = service
    }
}
