import Foundation

struct LikesGetRequest: NetworkRequest {
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)\(RequestConstants.profilePath)")
    }
    var httpMethod: HttpMethod = .get
    var dto: Dto?
}
