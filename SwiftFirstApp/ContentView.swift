import SwiftUI

struct ContentView: View {
    
    @StateObject private var authVM = AuthViewModel()
    
    var body: some View {
        NavigationStack {
            
            // Verification pour savoir si l'utilisateur est connecté
            if authVM.isAuthenticated {
                TabView {
                    MovieListView(authVM: authVM)
                        .environmentObject(authVM)
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
