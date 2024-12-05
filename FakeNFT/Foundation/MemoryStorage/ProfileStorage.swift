//
//  ProfileStoragee.swift
//  FakeNFT
//
//  Created by Soslan Dzampaev on 13.11.2024.
//

import Foundation

protocol ProfileStorage: AnyObject {
    func saveProfile(_ profile: Profile)
    func getProfile() -> Profile?
}

final class ProfileStorageImpl: ProfileStorage {
    // MARK: - Private properties
    private var storage: Profile?
    private let syncQueue = DispatchQueue(label: "sync-profile-queue")
    
    // MARK: - Public methods
    func saveProfile(_ profile: Profile) {
        syncQueue.async { [weak self] in
            self?.storage = profile
        }
    }
    
    func getProfile() -> Profile? {
        syncQueue.sync {
            storage
        }
    }
}
