import Foundation
import Combine
private let accessToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3MjdiMzkwZjAyZTczY2YzZWYzZGI5MzgzODg4NjZiNSIsIm5iZiI6MTc3MDI4NTM4Ny43NTQsInN1YiI6IjY5ODQ2OTRiZjhmNWZiZWZkYTM2MzM4NiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.FMzzldr2Zq6ukHp5HYhJru5njntRL-_NpKCNTUNR9zI"

private let myUrl : String = "https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc"

private let mockedMovies: [Movie] = [
    Movie(
        id: 1,
        original_language: "fr",
        original_title: "Titre Test 1",
        overview: "",
        title: "Film mocke 1",
        poster_path : nil,
        vote_average : 2.2
    ),
    Movie(
        id: 2,
        original_language: "en",
        original_title: "Test title 2",
        overview: "",
        title: "Mocked film 2",
        poster_path : nil,
        vote_average : 4.7
    ),
    Movie(
        id: 3,
        original_language: "fr",
        original_title: "Titre Test 3",
        overview: "",
        title: "Film mocke 3",
        poster_path : nil,
        vote_average : 9.5
    )
]

public class MovieAPIService {
    public func fetchMoviesAPI() async throws -> [Movie] {

        guard let url = URL(string: myUrl) else {
            return []
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }

        do {
            let decoded = try JSONDecoder().decode(MovieResponse.self, from: data)
            print("Movies : \(decoded.results)")
            return decoded.results
        } catch {
            print("erreur : \(error)")
            return mockedMovies
        }
    }
}
