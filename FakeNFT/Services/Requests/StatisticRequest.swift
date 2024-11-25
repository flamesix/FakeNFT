import Foundation

struct StatisticRequest: NetworkRequest {
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/users?page=\(page)&size=\(size)")
    }
    var httpMethod: HttpMethod = .get
    var dto: Dto?
    var page: Int
    let size: Int = 10
}
