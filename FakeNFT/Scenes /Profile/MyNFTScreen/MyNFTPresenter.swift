//
//  MyNFTPresenter.swift
//  FakeNFT
//
//  Created by Soslan Dzampaev on 29.11.2024.
//

import Foundation

enum SortOption {
    case price
    case rating
    case name
}

protocol MyNFTView: AnyObject {
    func showLoading()
    func hideLoading()
    func showError(_ message: String)
    func updateNftItems(_ items: [FavouriteNftModel])
    func showStubUI()
    func hideStubUI()
}

final class MyNFTPresenter {
    private weak var view: MyNFTView?
    private let nftService: ProfileServiceImpl = ProfileServiceImpl.shared
    private var myNfts: [String]
    private var nftItems: [FavouriteNftModel] = []

    init(view: MyNFTView, myNfts: [String]) {
        self.view = view
        self.myNfts = myNfts
    }

    func viewDidLoad() {
        loadData()
    }

    func viewWillAppear() {
        loadData()
    }

    private func loadData() {
        guard !myNfts.isEmpty else {
            view?.showStubUI()
            return
        }

        view?.showLoading()
        loadNfts(for: myNfts) { [weak self] nfts in
            DispatchQueue.main.async {
                self?.view?.hideLoading()
                self?.nftItems = nfts
                if nfts.isEmpty {
                    self?.view?.showStubUI()
                } else {
                    self?.view?.hideStubUI()
                    self?.view?.updateNftItems(nfts)
                }
            }
        }
    }

    private func loadNfts(for ids: [String], completion: @escaping ([FavouriteNftModel]) -> Void) {
        var loadedNfts: [FavouriteNftModel] = []
        let group = DispatchGroup()

        for id in ids {
            group.enter()
            nftService.getNft(by: id) { result in
                defer { group.leave() }
                switch result {
                case .success(let nft):
                    loadedNfts.append(nft)
                case .failure(let error):
                    print("Не удалось загрузить NFT с ID \(id): \(error.localizedDescription)")
                }
            }
        }

        group.notify(queue: .main) {
            completion(loadedNfts)
        }
    }

    func didSelectSortOption(_ option: SortOption) {
        sortNFTItems(by: option)
    }

    private func sortNFTItems(by option: SortOption) {
        switch option {
        case .price:
            nftItems.sort { $0.price > $1.price }
        case .rating:
            nftItems.sort { $0.rating > $1.rating }
        case .name:
            nftItems.sort { $0.name < $1.name }
        }
        view?.updateNftItems(nftItems)
    }
}
