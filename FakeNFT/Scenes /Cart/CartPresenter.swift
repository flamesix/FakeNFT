//
//  CartPresenter.swift
//  FakeNFT
//
//  Created by Pavel Bobkov on 12.11.2024.
//

import UIKit

protocol CartPresenterProtocol {
    func viewDidLoad()
    func getNumberOfNftInOrder() -> Int
    func getOrderTotalCost() -> Float
    func configureCell(for cell: NftCartCell, with indexPath: IndexPath)
    func openSortMenu()
}

// MARK: - State

enum CartState {
    case initial, loadingCart, loadingNfts(Cart), failed(Error), cartData(Cart), nftsData([Nft])
}

final class CartPresenter: CartPresenterProtocol {
    
    // MARK: - Properties
    
    weak var view: CartViewProtocol?
    
    private var nfts: [Nft] = [] {
        didSet {
            view?.updateCart()
        }
    }
    
    private var state = CartState.initial {
        didSet {
            stateDidChanged()
        }
    }
    
    private let cartService: CartServiceProtocol
    private let nftService: NftService
    
    // MARK: - Init
    
    init(cartService: CartServiceProtocol, nftService: NftService) {
        self.cartService = cartService
        self.nftService = nftService
    }
    
    // MARK: - Public Methods
    
    func viewDidLoad() {
        state = .loadingCart
    }
    
    func getNumberOfNftInOrder() -> Int {
        nfts.count
    }
    
    func getOrderTotalCost() -> Float {
        var totalCost: Float = 0
        nfts.forEach { totalCost += $0.price }
        return totalCost
    }
    
    func openSortMenu() {}
    
    func configureCell(for cell: NftCartCell, with indexPath: IndexPath) {
        let nft = nfts[indexPath.row]
        cell.configure(images: nft.images, name: nft.name, rating: nft.rating, price: nft.price)
    }
    
    // MARK: - Private Methods
    
    private func stateDidChanged() {
        switch state {
        case .initial:
            assertionFailure("can't move to initial state")
        case .loadingCart:
            view?.showLoading()
            loadCart()
        case .loadingNfts(let cart):
            loadNfts(cart: cart)
        case .cartData(let cart):
            if cart.nfts.isEmpty {
                view?.showEmptyInfo()
                view?.hideLoading()
            } else {
                self.state = .loadingNfts(cart)
            }
        case .nftsData(let nfts):
            self.nfts = nfts
            view?.hideLoading()
        case .failed(let error):
            let errorModel = makeErrorModel(error)
            view?.hideLoading()
            view?.showError(errorModel)
        }
    }
    
    private func loadCart() {
        cartService.loadCart() { [weak self] result in
            switch result {
            case .success(let cart):
                self?.state = .cartData(cart)
            case .failure(let error):
                self?.state = .failed(error)
            }
        }
    }
    
    private func loadNfts(cart: Cart) {
        nftService.loadNfts(ids: cart.nfts) { [weak self] result in
            switch result {
            case .success(let nfts):
                self?.state = .nftsData(nfts)
            case .failure(let error):
                self?.state = .failed(error)
            }
        }
    }
    
    private func makeErrorModel(_ error: Error) -> ErrorModel {
        let message: String
        switch error {
        case is NetworkClientError:
            message = NSLocalizedString("Error.network", comment: "")
        default:
            message = NSLocalizedString("Error.unknown", comment: "")
        }
        
        let actionText = NSLocalizedString("Error.repeat", comment: "")
        return ErrorModel(message: message, actionText: actionText) { [weak self] in
            self?.state = .loadingCart
        }
    }
}
