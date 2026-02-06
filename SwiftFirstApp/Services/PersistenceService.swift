import Foundation

final class PersistenceService {
    
    private static let userKey = "currentUser"
    
    // Sauvegarder l'utilisateur
    static func saveUser(_ user: User) {
        do {
            let data = try JSONEncoder().encode(user)
            UserDefaults.standard.set(data, forKey: userKey)
        } catch {
            print("Error saving user:", error)
        }
    }
    
    // Charger l'utilisateur
    static func loadUser() -> User? {
        guard let data = UserDefaults.standard.data(forKey: userKey) else {
            return nil
        }
        
        do {
            return try JSONDecoder().decode(User.self, from: data)
        } catch {
            print("Error loading user:", error)
            return nil
        }
    }
    
    // Supprimer l'utilisateur courant
    static func deleteUser() {
        UserDefaults.standard.removeObject(forKey: userKey)
    }
}
