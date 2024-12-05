import Foundation

typealias NftLikesCompletion = (Result<NftProfile, Error>) -> Void

protocol NftLikesServiceProtocol {
    func loadNftLikes(completion: @escaping NftLikesCompletion)
}

final class NftLikesService: NftLikesServiceProtocol {

    private let networkClient: NetworkClient

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func loadNftLikes(completion: @escaping NftLikesCompletion) {

        let request = NftProfileRequest()
        networkClient.send(request: request, type: NftProfile.self) {result in
            switch result {
            case .success(let nftLikes):
                completion(.success(nftLikes))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
