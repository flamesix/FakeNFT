import Foundation

protocol NftCollectionItemsStorage: AnyObject {
    func saveNftCollectionItems(_ nftItem: NftCollectionItem)
    func getNftCollectionItems(id: String) -> NftCollectionItem?
}

final class NftCollectionItemsStorageImpl: NftCollectionItemsStorage {
    private var storage: [String : NftCollectionItem] = [ : ]

    private let syncQueue = DispatchQueue(label: "sync-nftCollection-queue")

    func saveNftCollectionItems(_ nftItem: NftCollectionItem) {
        syncQueue.async { [weak self] in
            self?.storage[ nftItem.id ] = nftItem
        }
    }

    func getNftCollectionItems(id: String) -> NftCollectionItem? {
        syncQueue.sync {
            storage[id]
        }
    }
}
