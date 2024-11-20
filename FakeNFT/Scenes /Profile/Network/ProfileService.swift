//
//  ProfileService.swift
//  FakeNFT
//
//  Created by Soslan Dzampaev on 13.11.2024.
//

import Foundation

typealias ProfileCompletion = (Result<Profile, Error>) -> Void
typealias ProfileUpdateCompletion = (Result<Profile, Error>) -> Void

protocol ProfileService {
    func loadProfile(completion: @escaping ProfileCompletion)
    func updateProfile(
            name: String?,
            description: String?,
            website: String?,
            completion: @escaping ProfileUpdateCompletion
        )
}
final class ProfileServiceImpl: ProfileService {
    static let shared = ProfileServiceImpl(
        networkClient: DefaultNetworkClient(),
        storage: ProfileStorageImpl()
    )
    
    private let networkClient: NetworkClient
    private let storage: ProfileStorage
    
    init(networkClient: NetworkClient, storage: ProfileStorage) {
        self.networkClient = networkClient
        self.storage = storage
    }
    
    func loadProfile(completion: @escaping ProfileCompletion) {
        if let cachedProfile = storage.getProfile() {
            completion(.success(cachedProfile))
        } else {
            let request = ProfileRequest()
            
            networkClient.send(request: request, type: Profile.self) { [weak self] result in
                switch result {
                case .success(let profile):
                    self?.storage.saveProfile(profile)
                    completion(.success(profile))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }

    func updateProfile(
        name: String?,
        description: String?,
        website: String?,
        completion: @escaping ProfileUpdateCompletion
    ) {
        let dto = ProfileUpdateDto(name: name, description: description, website: website)
        let request = ProfileUpdateRequest(dto: dto)
        
        networkClient.send(request: request, type: Profile.self) { [weak self] result in
            switch result {
            case .success(let updatedProfile):
                self?.storage.saveProfile(updatedProfile) 
                completion(.success(updatedProfile))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

extension Notification.Name {
    static let profileUpdated = Notification.Name("profileUpdated")
}
