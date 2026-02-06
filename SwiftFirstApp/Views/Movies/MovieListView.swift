import SwiftUI

struct MovieListView: View {
    @StateObject private var vm = MovieListViewModel()
    @EnvironmentObject var authVM: AuthViewModel
    @StateObject private var favoritesVM: FavoritesViewModel

    init(authVM: AuthViewModel) {
        _favoritesVM = StateObject(wrappedValue: FavoritesViewModel(authVM: authVM))
    }

    var body: some View {
        Group {
            if vm.isLoading {
                ProgressView("Chargement...")
            } else {
                List(vm.movies) { movie in
                    NavigationLink {
                        MovieDetailView(movie: movie, favoritesVM: favoritesVM)
                    } label: {
                        MovieRowView(movie: movie)
                    }
                }
                .navigationTitle("Films")
            }
        }
        .task {
            await vm.loadMovies()
        }
    }
}
