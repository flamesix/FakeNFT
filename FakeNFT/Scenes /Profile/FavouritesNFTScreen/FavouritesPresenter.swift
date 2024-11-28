//
//  FavouritesPresenter.swift
//  FakeNFT
//
//  Created by Soslan Dzampaev on 29.11.2024.
//
import Foundation

protocol FavouritesView: AnyObject {
    func showLoading()
    func hideLoading()
    func showError(_ message: String)
    func updateNftItems(_ items: [FavouriteNftModel])
    func showStubUI()
    func hideStubUI()
}

final class FavouritesPresenter {
    private weak var view: FavouritesView?
    private let nftService: ProfileServiceImpl = ProfileServiceImpl.shared
    private var favoriteNfts: [String?]
    private var nftItems: [FavouriteNftModel] = []

    init(view: FavouritesView, favoriteNfts: [String?]) {
        self.view = view
        self.favoriteNfts = favoriteNfts
    }

    func viewDidLoad() {
        loadData()
    }

    func viewWillAppear() {
        loadData()
    }

    private func loadData() {
        let ids = favoriteNfts.compactMap { $0 }
        guard !ids.isEmpty else {
            view?.showStubUI()
            return
        }

        view?.showLoading()
        loadNfts(for: ids) { [weak self] nfts in
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

    func handleLikeAction(for nft: FavouriteNftModel) {
        let nftId = nft.id
        guard let indexToDelete = nftItems.firstIndex(where: { $0.id == nftId }) else {
            print("NFT с указанным id не найден")
            return
        }

        nftItems.remove(at: indexToDelete)

        if let favoriteIndex = favoriteNfts.firstIndex(of: nftId) {
            favoriteNfts.remove(at: favoriteIndex)
        }

        view?.updateNftItems(nftItems)
        updateLikesOnServer()

        NotificationCenter.default.post(name: .favouritesDidUpdate, object: nil, userInfo: ["favourites": favoriteNfts.compactMap { $0 }])
    }

    private func updateLikesOnServer() {
        let updatedLikes = nftItems.map { $0.id }

        view?.showLoading()
        nftService.updateLikes(updatedLikes) { [weak self] result in
            DispatchQueue.main.async {
                self?.view?.hideLoading()
                switch result {
                case .success:
                    print("Список избранного успешно обновлен на сервере")
                    NotificationCenter.default.post(name: .favouritesDidUpdate, object: nil, userInfo: ["count": updatedLikes.count])
                case .failure(let error):
                    print("Ошибка при обновлении избранного: \(error)")
                    self?.view?.showError("Не удалось обновить избранное")
                }
            }
        }
    }
}
