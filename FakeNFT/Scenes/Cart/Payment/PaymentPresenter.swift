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
    func payOrder()
}

// MARK: - Enum

enum PaymentState {
    case initial, loadingCurrencies, failedCurrencies(Error), data([Currency]), payingOrder, failedPay, payed
}

enum PaymentConstants: String {
    case userAgreementUrl = "https://yandex.ru/legal/practicum_termsofuse/"
}

final class PaymentPresenter: PaymentPresenterProtocol {
    
    // MARK: - Properties
    
    weak var view: PaymentViewProtocol?
    
    private var selectedCurrency: Currency?
    
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
    private let deleteNftService: DeleteNftServiceProtocol
    
    // MARK: - Init
    
    init(paymentService: PaymentServiceProtocol, deleteNftService: DeleteNftServiceProtocol) {
        self.paymentService = paymentService
        self.deleteNftService = deleteNftService
    }
    
    // MARK: - Public Methods
    
    func viewDidLoad() {
        state = .loadingCurrencies
    }
    
    func getCurrencyNumber() -> Int {
        currencies.count
    }
    
    func configureCell(for cell: CurrencyCell, with indexPath: IndexPath) {
        let currency = currencies[indexPath.row]
        cell.configure(title: currency.title, ticker: currency.name, image: currency.image)
    }
    
    func setCurrency(by indexPath: IndexPath) {
        self.selectedCurrency = currencies[indexPath.row]
    }
    
    func payOrder() {
        state = .payingOrder
    }
    
    // MARK: - Private Methods
    
    private func stateDidChanged() {
        switch state {
        case .initial:
            assertionFailure("can't move to initial state")
        case .loadingCurrencies:
            view?.showLoading()
            loadCurrencies()
        case .data(let currencies):
            self.currencies = currencies
            view?.hideLoading()
        case .failedCurrencies(let error):
            let errorModel = makeErrorModel(error)
            view?.hideLoading()
            view?.showError(errorModel)
        case .payingOrder:
            view?.showLoading()
            pay()
        case .payed:
            view?.hideLoading()
            cleanCart()
            view?.showSuccessPaymnetView()
        case .failedPay:
            view?.hideLoading()
            view?.showPayError()
        }
    }
    
    private func loadCurrencies() {
        paymentService.loadCurrencies() { [weak self] result in
            switch result {
            case .success(let currencies):
                self?.state = .data(currencies)
            case .failure(let error):
                self?.state = .failedCurrencies(error)
            }
        }
    }
    
    private func pay() {
        guard let currency = selectedCurrency else { return }
        paymentService.payOrder(currency_id: currency.id) { [weak self] result in
            switch result {
            case .success:
                self?.state = .payed
            case .failure:
                self?.state = .failedPay
            }
        }
    }
    
    private func cleanCart() {
        deleteNftService.updateCart(nfts: []) { _ in }
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
            self?.state = .loadingCurrencies
        }
    }
}
