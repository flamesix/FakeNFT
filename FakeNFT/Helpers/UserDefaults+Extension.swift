//
//  UserDefaults+Extension.swift
//  FakeNFT
//
//  Created by Pavel Bobkov on 14.11.2024.
//

import Foundation

extension UserDefaults {
    private enum Keys {
        static let sortType = "sortType"
    }

    func saveSortType(_ sortType: SortType) {
        set(sortType.rawValue, forKey: Keys.sortType)
    }
    
    func getSortType() -> SortType? {
        guard let rawValue = string(forKey: Keys.sortType) else {
            return nil
        }
        return SortType(rawValue: rawValue)
    }
}
