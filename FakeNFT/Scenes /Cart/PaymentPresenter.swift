//
//  PaymentPresenter.swift
//  FakeNFT
//
//  Created by Pavel Bobkov on 16.11.2024.
//

import Foundation

protocol PaymentPresenterProtocol {
    func getCurrencyNumber() -> Int
    func viewDidLoad()
    func configureCell(for cell: CurrencyCell, with indexPath: IndexPath)
    func setCurrency(by indexPath: IndexPath)
}

// MARK: - Enum

enum PaymentState {
    case initial, loading, failed(Error), data([Currency])
}

final class PaymentPresenter: PaymentPresenterProtocol {
    
    // MARK: - Properties
    
    weak var view: PaymentViewProtocol?
    
    private var selectedCyrency: Currency?
    
    private var state = PaymentState.initial {
        didSet {
            stateDidChanged()
        }
    }
    
    private var currencies: [Currency] = [] {
        didSet {
            view?.updateCollection()
        }
    }
    
    private let paymentService: PaymentServiceProtocol
    
    // MARK: - Init
    
    init(paymentService: PaymentServiceProtocol) {
        self.paymentService = paymentService
    }
    
    // MARK: - Public Methods
    
    func viewDidLoad() {
        state = .loading
    }
    
    func getCurrencyNumber() -> Int {
        currencies.count
    }
    
    func configureCell(for cell: CurrencyCell, with indexPath: IndexPath) {
        let currency = currencies[indexPath.row]
        cell.configure(title: currency.title, ticker: currency.name, image: currency.image)
    }
    
    func setCurrency(by indexPath: IndexPath) {
        self.selectedCyrency = currencies[indexPath.row]
    }
    
    // MARK: - Private Methods
    
    private func stateDidChanged() {
        switch state {
        case .initial:
            assertionFailure("can't move to initial state")
        case .loading:
            view?.showLoading()
            loadCurrencies()
        case .data(let currencies):
            self.currencies = currencies
            view?.hideLoading()
        case .failed(let error):
            let errorModel = makeErrorModel(error)
            view?.hideLoading()
            view?.showError(errorModel)
        }
    }
    
    private func loadCurrencies() {
        paymentService.loadCurrencies() { [weak self] result in
            switch result {
            case .success(let currencies):
                self?.state = .data(currencies)
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
            self?.state = .loading
        }
    }
}
