//
//  CartPresenter.swift
//  FakeNFT
//
//  Created by Pavel Bobkov on 12.11.2024.
//

import Foundation

protocol CartPresenterProtocol {
    func viewDidLoad()
    func getNumberOfNftInOrder() -> Int
    func getOrderTotalCost() -> Float
    func configureCell(for cell: NftCartCell, with indexPath: IndexPath)
    func sortBy(_: SortType)
    func deleteNft(from indexPath: IndexPath)
}

// MARK: - Enum

enum CartState {
    case initial, loadingCart, loadingNfts(Cart), failed(Error), cartData(Cart), nftsData([Nft])
}

enum SortType: String {
    case byPrice, byRating, byName
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
    
    private let sortStorage: CartSortStorageProtocol
    private let cartService: CartServiceProtocol
    private let nftService: NftService
    
    // MARK: - Init
    
    init(sortStorage: CartSortStorageProtocol, cartService: CartServiceProtocol, nftService: NftService) {
        self.sortStorage = sortStorage
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
    
    func sortBy(_ type: SortType) {
        self.nfts = sortNFTs(self.nfts, by: type)
        view?.updateCart()
        sortStorage.saveSortType(type)
    }
    
    func configureCell(for cell: NftCartCell, with indexPath: IndexPath) {
        let nft = nfts[indexPath.row]
        cell.configure(images: nft.images, name: nft.name, rating: nft.rating, price: nft.price)
    }
    
    func deleteNft(from indexPath: IndexPath) { }
    
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
            var sortType: SortType = .byName
            if let savedSortType = sortStorage.getSortType() {
                sortType = savedSortType
            }
            self.nfts = sortNFTs(nfts, by: sortType)
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
    
    private func sortNFTs(_ nfts: [Nft], by option: SortType) -> [Nft] {
        switch option {
        case .byName:
            return nfts.sorted { $0.name < $1.name }
        case .byPrice:
            return nfts.sorted { $0.price < $1.price }
        case .byRating:
            return nfts.sorted { $0.rating < $1.rating }
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
