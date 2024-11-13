//
//  NftCatalogueItemPresenter.swift
//  FakeNFT
//
//  Created by Федор Завьялов on 12.11.2024.
//

import UIKit

// MARK: - Protocol

protocol NftCatalogueItemPresenterProtocol {
    func viewDidLoad()
}

enum NftCatalogueItemState {
    case initial, loading, failed(Error), data([NftCollectionItem])
}

final class NftCatalogueItemPresenter: NftCatalogueItemPresenterProtocol {
    
    // MARK: - Properties

    weak var view: NftCatalogueItemViewControllerProtocol?
    private var input: [String]
    private var output: [NftCollectionItem] = []
    private let service: NftItemsService
    private var state = NftCatalogueItemState.initial {
        didSet {
            stateDidChanged()
        }
    }
    

    // MARK: - Init

    init(input: [String], service: NftItemsService) {
        self.input = input
        self.service = service
    }

    // MARK: - Functions

    func viewDidLoad() {
        state = .loading
    }

    private func stateDidChanged() {
        switch state {
        case .initial:
            assertionFailure("can't move to initial state")
        case .loading:
            view?.showLoading()
            let id = input.removeFirst()
            loadNftCollectionItems(id: id)
        case .data(let nftItems):
            if 0 < input.count {
                state = .loading
            } else {
                view?.hideLoading()
                view?.displayItems(nftItems)
                
            }
        case .failed(let error):
            let errorModel = makeErrorModel(error)
            view?.hideLoading()
            view?.showError(errorModel)
        }
    }

    private func loadNftCollectionItems(id: String) {
            service.loadNftItems(id: id) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let nftItems):
                    self.output.append(nftItems)
                    self.state = .data(output)
                case .failure(let error):
                    self.state = .failed(error)
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
            self?.state = .loading
        }
    }
}
