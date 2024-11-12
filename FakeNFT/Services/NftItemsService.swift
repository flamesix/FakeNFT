import Foundation

typealias NftItemCompletion = (Result<[NftCollectionItem], Error>) -> Void

protocol NftItemsService {
    func loadNftItems(completion: @escaping NftItemCompletion)
}

final class NftItemsServiceImpl: NftItemsService {

    private let networkClient: NetworkClient
    private let storage: NftCollectionItemsStorage

    init(networkClient: NetworkClient, storage: NftCollectionItemsStorage) {
        self.storage = storage
        self.networkClient = networkClient
    }

    func loadNftItems(completion: @escaping NftItemCompletion) {
        if let nftItems = storage.getNftCollectionItems() {
            completion(.success(nftItems))
            return
        }

        let request = NftCollectionItemsRequest()
        networkClient.send(request: request, type: [NftCollectionItem].self) { [weak storage] result in
            switch result {
            case .success(let nftItems):
                storage?.saveNftCollectionItems(nftItems)
                completion(.success(nftItems))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
