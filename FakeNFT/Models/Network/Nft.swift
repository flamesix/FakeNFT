import Foundation

struct Nft: Decodable {
    let name: String
    let id: String
    let rating: Int
    let price: Decimal
    let images: [URL]
}
