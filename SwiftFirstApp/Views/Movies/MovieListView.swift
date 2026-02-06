import SwiftUI

struct MovieListView: View {
    @StateObject private var vm = MovieListViewModel()
    @EnvironmentObject var authVM: AuthViewModel

    var body: some View {
        let favoritesVM = FavoritesViewModel(authVM: authVM)

        NavigationStack {
            if !vm.isLoading {
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
