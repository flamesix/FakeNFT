//
//  ProfilePresenter.swift
//  FakeNFT
//
//  Created by Soslan Dzampaev on 17.11.2024.
//

import Foundation

protocol ProfileViewProtocol: AnyObject {
    func updateUI(with profile: Profile)
    func showError(_ error: String)
}

final class ProfilePresenter {
    private weak var view: ProfileViewProtocol?
    private let profileService: ProfileService
    private var profile: Profile?
    
    
    // MARK: - Init
    init(view: ProfileViewProtocol, profileService: ProfileService = ProfileServiceImpl.shared) {
        self.view = view
        self.profileService = profileService
    }
    
    func loadProfileData() {
        profileService.loadProfile { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let profile):
                    self?.profile = profile
                    self?.view?.updateUI(with: profile)
                case .failure(let error):
                    self?.view?.showError("Error loading profile: \(error.localizedDescription)")
                    print("Error loading profile:", error.localizedDescription)
                }
            }
        }
    }
    
    func getNFTCount() -> Int {
        return profile?.nfts?.count ?? 0
    }
    
    func getNFTs() -> [String] {
        return profile?.nfts ?? []
    }
    
    func getLikesCount() -> Int {
        return profile?.likes?.count ?? 0
    }
    
    func getLikes() -> [String] {
        return profile?.likes ?? []
    }
    
    func updateLikes(_ likes: [String]) {
        profile?.likes = likes 
    }
}
