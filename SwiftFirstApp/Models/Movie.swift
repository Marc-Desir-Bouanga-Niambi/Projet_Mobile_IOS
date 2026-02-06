import Foundation

public struct MovieResponse: Decodable {
    let results: [Movie]
}

public struct Movie: Identifiable, Codable {
    public let id: Int
    let original_language : String
    let original_title: String
    let overview: String
    let title: String
    let poster_path: String?
    let vote_average: Double
}
extension Movie {
    var posterURL : URL? {
        guard let poster_path else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(poster_path)")
    }
}
