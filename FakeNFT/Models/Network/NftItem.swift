import Foundation

struct NftItem: Decodable {
    let id: String
    let name: String
    let images: [URL]
    let rating: Int
    let preice: Float
}
