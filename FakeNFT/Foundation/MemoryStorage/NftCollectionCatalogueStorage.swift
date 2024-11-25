import Foundation

protocol NftCollectionCatalogueStorage: AnyObject {
    func saveNftCollectionCatalogue(_ nftCatalogue: [Catalogue])
    func getNftCollectionCatalogue() -> [Catalogue]?
}

final class NftCollectionCatalogueStorageImpl: NftCollectionCatalogueStorage {
    private var storage: [Catalogue]?

    private let syncQueue = DispatchQueue(label: "sync-nftCollection-queue")

    func saveNftCollectionCatalogue(_ nftCatalogue: [Catalogue]) {
        syncQueue.async { [weak self] in
            self?.storage = nftCatalogue
        }
    }

    func getNftCollectionCatalogue() -> [Catalogue]? {
        syncQueue.sync {
            storage
        }
    }
}
