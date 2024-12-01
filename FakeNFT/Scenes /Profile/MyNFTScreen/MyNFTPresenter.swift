//
//  MyNFTPresenter.swift
//  FakeNFT
//
//  Created by Soslan Dzampaev on 29.11.2024.
//

import Foundation

enum SortOption: String {
    case price
    case rating
    case name
    
    func save() {
        UserDefaults.standard.set(self.rawValue, forKey: "selectedSortOption")
    }
    
    static func restore() -> SortOption {
        if let savedOption = UserDefaults.standard.string(forKey: "selectedSortOption"),
           let sortOption = SortOption(rawValue: savedOption) {
            return sortOption
        }
        return .price
    }
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
    // MARK: - Public properties
    var nftItems: [FavouriteNftModel] = []
    var favoriteNfts: [String?]
    
    // MARK: - Private methods
    private weak var view: MyNFTView?
    private let nftService: ProfileServiceImpl = ProfileServiceImpl.shared
    private var myNfts: [String]
    private var currentSortOption: SortOption
    
    
    init(view: MyNFTView, myNfts: [String], favoriteNfts: [String?]) {
        self.view = view
        self.myNfts = myNfts
        self.favoriteNfts = favoriteNfts
        self.currentSortOption = SortOption.restore()
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
                
                for nft in self?.nftItems ?? [] {
                    let isLiked = self?.favoriteNfts.contains(nft.id) ?? false
                    self?.view?.updateNftItems(self?.nftItems ?? [])
                }
                
                if nfts.isEmpty {
                    self?.view?.showStubUI()
                } else {
                    self?.view?.hideStubUI()
                    self?.applySorting()
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
        option.save()
        self.currentSortOption = option
        sortNFTItems(by: option)
    }
    
    func handleLikeAction(for nft: FavouriteNftModel) {
        let nftId = nft.id
        
        if let favoriteIndex = favoriteNfts.firstIndex(of: nftId) {
            favoriteNfts.remove(at: favoriteIndex)
        } else {
            favoriteNfts.append(nftId)
        }
        updateLikesOnServer()
        NotificationCenter.default.post(name: .favouritesDidUpdate, object: nil, userInfo: ["favourites": favoriteNfts])
    }

    private func updateLikesOnServer() {
        let updatedLikes = favoriteNfts.compactMap { $0 }
        
        view?.showLoading()
        nftService.updateLikes(updatedLikes) { [weak self] result in
            DispatchQueue.main.async {
                self?.view?.hideLoading()
                switch result {
                case .success:
                    NotificationCenter.default.post(name: .favouritesDidUpdate, object: nil, userInfo: ["count": updatedLikes.count])
                case .failure(let error):
                    assertionFailure("Ошибка при обновлении избранного: \(error)")
                    self?.view?.showError("Не удалось обновить избранное")
                }
            }
        }
    }
    
    private func sortNFTItems(by option: SortOption) {
        switch option {
        case .price:
            nftItems.sort { $0.price < $1.price }
        case .rating:
            nftItems.sort { $0.rating > $1.rating }
        case .name:
            nftItems.sort { $0.name < $1.name }
        }
        view?.updateNftItems(nftItems)
    }
    
    private func applySorting() {
        sortNFTItems(by: currentSortOption)
    }
}
