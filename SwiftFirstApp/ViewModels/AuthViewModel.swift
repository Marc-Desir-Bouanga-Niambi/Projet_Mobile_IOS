import Foundation
import Combine


final class AuthViewModel: ObservableObject {
    

    
    @Published var currentUser: User?
    @Published var errorMessage: String?
    @Published var isAuthenticated: Bool = false
    

    
    init() {
        loadUser()
    }
    

    
    /// Création de compte
    func register(name: String, email: String, password: String) {
        guard !name.isEmpty, !email.isEmpty, !password.isEmpty else {
            errorMessage = "Tous les champs sont obligatoires"
            return
        }
        
        let newUser = User(
            id: UUID(),
            name: name,
            email: email,
            password: password,
            favoriteMovieIds: []
        )
        
        PersistenceService.saveUser(newUser)
        currentUser = newUser
        isAuthenticated = true
        errorMessage = nil
    }
    
    /// Connexion
    func login(email: String, password: String) {
        guard let savedUser = PersistenceService.loadUser() else {
            errorMessage = "Aucun utilisateur enregistré"
            return
        }
        
        guard savedUser.email == email, savedUser.password == password else {
            errorMessage = "Email ou mot de passe incorrect"
            return
        }
        
        currentUser = savedUser
        isAuthenticated = true
        errorMessage = nil
    }
    
    /// Déconnexion
    func logout() {
        PersistenceService.deleteUser()
        currentUser = nil
        isAuthenticated = false
        errorMessage = nil
    }
    
    // MARK: - Private methods
    
    private func loadUser() {
        if let user = PersistenceService.loadUser() {
            currentUser = user
            isAuthenticated = true
        }
    }
}

