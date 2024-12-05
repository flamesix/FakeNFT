import Foundation

struct NftProfileRequest: NetworkRequest {
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)\(RequestConstants.profilePath)")
    }
    var dto: Dto?
}
