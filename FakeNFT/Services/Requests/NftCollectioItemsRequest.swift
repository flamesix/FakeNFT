import Foundation

struct NftCollectionItemsRequest: NetworkRequest {
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/nft")
    }
    var dto: Dto?
}
