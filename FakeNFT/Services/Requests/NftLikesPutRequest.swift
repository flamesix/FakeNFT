import Foundation

struct LikesPutRequest: NetworkRequest {
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)\(RequestConstants.profilePath)")
    }
    var httpMethod: HttpMethod = .put
    var dto: Dto?
}

struct LikesDtoObject: Dto {
    let likes: [String]?

    func asDictionary() -> [String: String] {
        var dict: [String: String] = [:]
        if let likes {
            dict["likes"] = likes.joined(separator: ",")
        } else {
            dict["likes"] = "null"
        }
        return dict
    }
}
