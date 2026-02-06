import Foundation
import Combine

final class MovieListViewModel: ObservableObject {
    
    @Published var movies: [Movie] = []
    @Published var errorMessage: String?
    
    private let movieService = MovieAPIService()
    
    func loadMovies() async {
        do {
            movies = try await movieService.fetchMoviesAPI()
        } catch {
            errorMessage = "Erreur"
        }
//        service.fetchMovies { [weak self] result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let movies):
//                    self?.movies = movies
//                    self?.errorMessage = nil
//                case .failure(let error):
//                    self?.movies = []
//                    self?.errorMessage = error.localizedDescription
//                }
//            }
//        }
    }
}
