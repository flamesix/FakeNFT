//
//  DeleteNftPresenter.swift
//  FakeNFT
//
//  Created by Pavel Bobkov on 17.11.2024.
//

import Foundation

protocol DeleteNftPresenterProtocol {
    func deleteNft()
    func getImage() -> URL?
}

protocol DeleteNftPresenterDelegate: AnyObject {
    func fetchCart(cart: Cart)
    func showError(error: Error)
}

final class DeleteNftPresenter: DeleteNftPresenterProtocol {
    
    // MARK: - Properties
    
    weak var view: DeleteNftViewProtocol?
    private let delegate: DeleteNftPresenterDelegate
    private let service: DeleteNftServiceProtocol
    private let deletedNft: Nft
    private let allNfts: [Nft]
    
    // MARK: - Init
    
    init(delegate: DeleteNftPresenterDelegate, service: DeleteNftServiceProtocol, deletedNft: Nft, allNfts: [Nft]) {
        self.delegate = delegate
        self.service = service
        self.deletedNft = deletedNft
        self.allNfts = allNfts
    }
    
    // MARK: - Public Methods
    
    func deleteNft() {
        var newCart: [String] = []
        
        allNfts.forEach {
            if $0.id != deletedNft.id {
                newCart.append($0.id)
            }
        }
        
        service.updateCart(nfts: newCart) { [weak self] result in
            switch result {
            case .success(let cart):
                self?.delegate.fetchCart(cart: cart)
                self?.view?.dismissView()
            case .failure(let error):
                self?.delegate.showError(error: error)
                self?.view?.dismissView()
            }
        }
    }
    
    func getImage() -> URL? {
        return deletedNft.images.first
    }
}
