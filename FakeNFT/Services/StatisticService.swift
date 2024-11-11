import Foundation

typealias StatisticCompletion = (Result<[User], Error>) -> Void

protocol StatisticsServiceProtocol {
    func loadUsers(completion: @escaping StatisticCompletion)
}

final class StatisticService: StatisticsServiceProtocol {

    private let networkClient: NetworkClient
//    private let storage: StatisticStorage

    init(networkClient: NetworkClient) {
//        self.storage = storage
        self.networkClient = networkClient
    }

    func loadUsers(completion: @escaping StatisticCompletion) {

        let request = StatisticRequest()
        networkClient.send(request: request, type: [User].self) { [weak self] result in
            switch result {
            case .success(let users):
                completion(.success(users))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
