//
//  CartSortStorage.swift
//  FakeNFT
//
//  Created by Pavel Bobkov on 14.11.2024.
//

import Foundation

protocol CartSortStorageProtocol {
    func saveSortType(_ sortType: SortType)
    func getSortType() -> SortType?
}

final class CartSortStorage: CartSortStorageProtocol {
    private let userDefaults: UserDefaults
    
    private enum Keys {
        static let sortType = "cartSortType"
    }
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    func saveSortType(_ sortType: SortType) {
        userDefaults.set(sortType.rawValue, forKey: Keys.sortType)
    }
    
    func getSortType() -> SortType? {
        guard let rawValue = userDefaults.string(forKey: Keys.sortType) else {
            return nil
        }
        return SortType(rawValue: rawValue)
    }
}
