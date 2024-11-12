import Foundation

protocol NftCollectionItemsStorage: AnyObject {
    func saveNftCollectionItems(_ nftCatalogue: [NftCollectionItem])
    func getNftCollectionItems() -> [NftCollectionItem]?
}

final class NftCollectionItemsStorageImpl: NftCollectionItemsStorage {
    private var storage: [NftCollectionItem]?

    private let syncQueue = DispatchQueue(label: "sync-nftCollection-queue")

    func saveNftCollectionItems(_ nftCatalogue: [NftCollectionItem]) {
        syncQueue.async { [weak self] in
            self?.storage = nftCatalogue
        }
    }

    func getNftCollectionItems() -> [NftCollectionItem]? {
        syncQueue.sync {
            storage
        }
    }
}
