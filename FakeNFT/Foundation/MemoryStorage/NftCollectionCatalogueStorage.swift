import Foundation

protocol NftCollectionCatalogueStorage: AnyObject {
    func saveNftCollectionCatalogue(_ nftCatalogue: [NftCatalogueCollection])
    func getNftCollectionCatalogue() -> [NftCatalogueCollection]?
}

final class NftCollectionCatalogueStorageImpl: NftCollectionCatalogueStorage {
    private var storage: [NftCatalogueCollection]?

    private let syncQueue = DispatchQueue(label: "sync-nftCollection-queue")

    func saveNftCollectionCatalogue(_ nftCatalogue: [NftCatalogueCollection]) {
        syncQueue.async { [weak self] in
            self?.storage = nftCatalogue
        }
    }

    func getNftCollectionCatalogue() -> [NftCatalogueCollection]? {
        syncQueue.sync {
            storage
        }
    }
}
