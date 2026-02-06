import Foundation
import Combine

final class MovieAPIService {
    
    func fetchMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            let movies = [
                Movie(
                    id: 1,
                    title: "Inception",
                    overview: "Un voleur qui vole les rêves des gens pour voler leurs secrets.",
                    posterPath: "inception_placeholder",
                    rating: 8.8
                ),
                Movie(
                    id: 2,
                    title: "The Matrix",
                    overview: "Un hacker découvre que la réalité qu’il connaît est une simulation.",
                    posterPath: "matrix_placeholder",
                    rating: 8.7
                ),
                Movie(
                    id: 3,
                    title: "Interstellar",
                    overview: "Exploration spatiale pour sauver l’humanité d’une Terre mourante.",
                    posterPath: "interstellar_placeholder",
                    rating: 8.6
                )
            ]
            completion(.success(movies))
        }
    }
}
