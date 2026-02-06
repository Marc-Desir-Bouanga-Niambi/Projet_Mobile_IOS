import Foundation
import Combine

final class FavoritesViewModel: ObservableObject {

    @Published var favoriteMovies: [Movie] = []
    @Published var errorMessage: String?

    private let authVM: AuthViewModel

    init(authVM: AuthViewModel) {
        self.authVM = authVM
        loadFavorites()
    }

    func loadFavorites() {
        guard let user = authVM.currentUser else {
            favoriteMovies = []
            return
        }

        favoriteMovies = user.favoriteMovies
    }

    func addToFavorites(movie: Movie) {
        guard var user = authVM.currentUser else { return }

        if !user.favoriteMovies.contains(where: { $0.id == movie.id }) {
            user.favoriteMovies.append(movie)
            authVM.currentUser = user
            PersistenceService.saveUser(user)
            loadFavorites()
        }
    }

    func removeFromFavorites(movie: Movie) {
        guard var user = authVM.currentUser else { return }

        if let index = user.favoriteMovies.firstIndex(where: { $0.id == movie.id }) {
            user.favoriteMovies.remove(at: index)
            authVM.currentUser = user
            PersistenceService.saveUser(user)
            loadFavorites()
        }
    }

    func isFavorite(_ movie: Movie) -> Bool {
        return authVM.currentUser?.favoriteMovies.contains(where: { $0.id == movie.id }) ?? false
    }
}
