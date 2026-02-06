import Foundation
import Combine

final class MovieListViewModel: ObservableObject {
    
    @Published var movies: [Movie] = []
    @Published var errorMessage: String?
    
    private let movieService = MovieAPIService()
    
    @MainActor
    func loadMovies() async {
        do {
            movies = try await movieService.fetchMoviesAPI()
        } catch {
            errorMessage = "Erreur"
        }
    }
}
