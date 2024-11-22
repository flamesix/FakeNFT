import Foundation

struct Nft: Decodable {
    let id: String
    let name: String
    let rating: Int
    let price: Double
    let images: [URL]
}
