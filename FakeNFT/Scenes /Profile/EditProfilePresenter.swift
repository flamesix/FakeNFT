//
//  EditProfilePresenter.swift
//  FakeNFT
//
//  Created by Soslan Dzampaev on 17.11.2024.
//

import Foundation

protocol EditProfileViewProtocol: AnyObject {
    func loadProfileData(profile: Profile)
    func showError(_ message: String)
}

final class EditProfilePresenter {
    private weak var view: EditProfileViewProtocol?
    private let profileService: ProfileService
    
    init(view: EditProfileViewProtocol, profileService: ProfileService = ProfileServiceImpl.shared) {
        self.view = view
        self.profileService = profileService
    }
    
    func loadProfileData(){
        profileService.loadProfile { [weak self] result in
            switch result{
            case .success(let profile):
                self?.view?.loadProfileData(profile: profile)
            case .failure(let error):
                self?.view?.showError("Error loading profile: \(error.localizedDescription)")
                print("Error loading profile:", error)
            }
        }
    }
}
