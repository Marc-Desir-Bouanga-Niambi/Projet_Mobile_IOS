import Foundation

public struct MovieResponse: Decodable {
    let results: [Movie]
}

public struct Movie: Identifiable, Codable {
    public let Id: Int
    let original_language : String
    let original_title: String
    let overview: String
    let title: String
    let posterPath: String?
    let rating: Double
}
extension Movie {
    var posterURL : URL? {
        guard let posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
    }
}
