import Foundation
import Combine

final class FavoritesViewModel: ObservableObject {

    // Liste des attributs
    @Published var favoriteMovies: [Movie] = []
    @Published var errorMessage: String?

    // Acces a l'utilisateur courant
    private let authVM: AuthViewModel
    
    // Constructeur
    init(authVM: AuthViewModel) {
        self.authVM = authVM
        loadFavorites()
    }

    // Fonction qui permet de charger les favoris de l'utilisateur si il est connecté
    func loadFavorites() {
        guard let user = authVM.currentUser else {
            favoriteMovies = []
            return
        }
        
        for movie in user.favoriteMovies {
            favoriteMovies.append(movie)
        }
    }

    // Fonction qui ajoute un film aux favoris de l'utilisateur
    func addToFavorites(movie: Movie) {
        guard var user = authVM.currentUser else { return }
        
        if !user.favoriteMovies.contains(where: { $0.Id == movie.Id }) {
            user.favoriteMovies.append(movie)
        }
    }

    // Fonction qui retire un film aux favoris de l'utilisateur
    func removeFromFavorites(movie: Movie) {
        guard var user = authVM.currentUser else { return }

        if let index = user.favoriteMovies.firstIndex(where: { $0.Id == movie.Id }) {
            user.favoriteMovies.remove(at: index)
            authVM.currentUser = user
            PersistenceService.saveUser(user)
            loadFavorites()
        }
    }

    // Vérifier si un film est favori
    func isFavorite(_ movie: Movie) -> Bool {
        return authVM.currentUser?.favoriteMovies.contains(where: { $0.Id == movie.Id }) ?? false
    }
}
