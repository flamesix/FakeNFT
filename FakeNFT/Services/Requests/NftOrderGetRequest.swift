import Foundation

struct OrdersGetRequest: NetworkRequest {
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)\(RequestConstants.orderPath)")
    }
    var httpMethod: HttpMethod = .get
    var dto: Dto?
}
