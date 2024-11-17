//
//  DeleteNftPresenter.swift
//  FakeNFT
//
//  Created by Pavel Bobkov on 17.11.2024.
//

import Foundation

protocol DeleteNftPresenterProtocol {
    func deleteNft()
    func getImage() -> URL?
}

final class DeleteNftPresenter: DeleteNftPresenterProtocol {
    
    // MARK: - Properties
    
    weak var view: DeleteNftViewProtocol?
    private let nft: Nft
    
    // MARK: - Init
    
    init(nft: Nft) {
        self.nft = nft
    }
    
    // MARK: - Public Methods
    
    func deleteNft() {
        
    }
    
    func getImage() -> URL? {
        return nft.images.first
    }
}

