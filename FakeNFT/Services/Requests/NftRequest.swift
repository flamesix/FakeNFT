import Foundation

<<<<<<<< HEAD:FakeNFT/Services/Requests/NftRequest.swift
struct NftRequest: NetworkRequest {
========
struct NftCollectionItemsRequest: NetworkRequest {
>>>>>>>> catalogue:FakeNFT/Services/Requests/NftCollectioItemsRequest.swift
    let id: String
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/nft/\(id)")
    }
    var dto: Dto?
}
