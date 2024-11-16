import Foundation

typealias NftCollectionCatalogueCompletion = (Result<[NftCatalogueCollection], Error>) -> Void

protocol NftCollectionCatalogueService {
    func loadNftCatalogue(page: Int, completion: @escaping NftCollectionCatalogueCompletion)
}

final class NftCollectionCatalogueServiceImpl: NftCollectionCatalogueService {

    private let networkClient: NetworkClient
    private let storage: NftCollectionCatalogueStorage

    init(networkClient: NetworkClient, storage: NftCollectionCatalogueStorage) {
        self.storage = storage
        self.networkClient = networkClient
    }
    
    func loadNftCatalogue(page: Int, completion: @escaping NftCollectionCatalogueCompletion) {
        if let nftCatalogue = storage.getNftCollectionCatalogue(), (page + 1) * 5 == nftCatalogue.count {
            completion(.success(nftCatalogue))
            return
        }

        let request = NftCatalogueCollectionRequest(page: page)
        networkClient.send(request: request, type: [NftCatalogueCollection].self) { [weak storage] result in
            switch result {
            case .success(let nftCollectionCatalogue):
                storage?.saveNftCollectionCatalogue(nftCollectionCatalogue)
                completion(.success(nftCollectionCatalogue))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
