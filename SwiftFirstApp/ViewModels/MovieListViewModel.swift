import Foundation
import Combine

final class MovieListViewModel: ObservableObject {
    
    @Published var movies: [Movie] = []
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    
    private let movieService = MovieAPIService()
    
    @MainActor
    func loadMovies() async {
        isLoading = true
        do {
            movies = try await movieService.fetchMoviesAPI()
        } catch {
            errorMessage = "Erreur"
        }
        isLoading = false
    }
}
