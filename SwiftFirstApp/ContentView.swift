import SwiftUI

struct ContentView: View {
    
    @StateObject private var authVM = AuthViewModel()
    
    var body: some View {
        NavigationStack {
            
            if authVM.isAuthenticated {
                // Utilisateur connecté
                TabView {
                    
                    MovieListView()
                        .tabItem {
                            Label("Films", systemImage: "film")
                        }
                    
                    FavoritesView(favoritesVM: FavoritesViewModel(authVM: authVM))
                        .tabItem {
                            Label("Favoris", systemImage: "heart")
                        }
                    
                    ProfileView()
                        .tabItem {
                            Label("Profil", systemImage: "person")
                        }
                }
                
            } else {
                // Utilisateur NON connecté
                LoginView()
            }
        }
        .environmentObject(authVM)
    }
}

#Preview {
    ContentView()
}
