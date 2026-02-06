import Foundation
import Combine

final class FavoritesViewModel: ObservableObject {
    @Published var favoriteMovies: [Movie] = []   // liste des films favoris
    @Published var errorMessage: String?

    private let authVM: AuthViewModel             // pour accéder à l'utilisateur courant
    private let movieService = MovieAPIService()  // pour charger les films si besoin

    init(authVM: AuthViewModel) {
        self.authVM = authVM
        loadFavorites()
    }

    // MARK: - Charger les favoris
    func loadFavorites() {
        guard let user = authVM.currentUser else {
            favoriteMovies = []
            return
        }

        // Ici on récupère les films à partir des IDs stockés dans user.favoriteMovieIds
        movieService.fetchMovies { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let allMovies):
                    // On filtre uniquement les films présents dans favoriteMovieIds
                    self?.favoriteMovies = allMovies.filter { user.favoriteMovieIds.contains($0.id) }
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }

    // MARK: - Ajouter un film aux favoris
    func addToFavorites(movie: Movie) {
        guard var user = authVM.currentUser else { return }

        if !user.favoriteMovieIds.contains(movie.id) {
            user.favoriteMovieIds.append(movie.id)
            authVM.currentUser = user                  // mettre à jour l’utilisateur courant
            PersistenceService.saveUser(user)          // persistance
            loadFavorites()                             // mettre à jour la liste
        }
    }

    // MARK: - Retirer un film des favoris
    func removeFromFavorites(movie: Movie) {
        guard var user = authVM.currentUser else { return }

        if let index = user.favoriteMovieIds.firstIndex(of: movie.id) {
            user.favoriteMovieIds.remove(at: index)
            authVM.currentUser = user
            PersistenceService.saveUser(user)
            loadFavorites()
        }
    }

    // MARK: - Vérifier si un film est favori
    func isFavorite(_ movie: Movie) -> Bool {
        return authVM.currentUser?.favoriteMovieIds.contains(movie.id) ?? false
    }
}
