import Foundation
import Combine

private let accessToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3MjdiMzkwZjAyZTczY2YzZWYzZGI5MzgzODg4NjZiNSIsIm5iZiI6MTc3MDI4NTM4Ny43NTQsInN1YiI6IjY5ODQ2OTRiZjhmNWZiZWZkYTM2MzM4NiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.FMzzldr2Zq6ukHp5HYhJru5njntRL-_NpKCNTUNR9zI"

final class MovieAPIService {
    public func fetchMoviesAPI() async throws -> [Movie] {
        guard let url = URL(string: "https://api.themoviedb.org/3/discover/movie") else {
            return []
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer (accessToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }

        let decoded = try JSONDecoder().decode(MovieResponse.self, from: data)
        return decoded.results
    }
    
//    func fetchMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
//        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
//            let movies = [
//                Movie(
//                    id: 1,
//                    title: "Inception",
//                    overview: "Un voleur qui vole les rêves des gens pour voler leurs secrets.",
//                    posterPath: "inception_placeholder",
//                    rating: 8.8
//                ),
//                Movie(
//                    id: 2,
//                    title: "The Matrix",
//                    overview: "Un hacker découvre que la réalité qu’il connaît est une simulation.",
//                    posterPath: "matrix_placeholder",
//                    rating: 8.7
//                ),
//                Movie(
//                    id: 3,
//                    title: "Interstellar",
//                    overview: "Exploration spatiale pour sauver l’humanité d’une Terre mourante.",
//                    posterPath: "interstellar_placeholder",
//                    rating: 8.6
//                )
//            ]
//            completion(.success(movies))
//        }
//    }
}
