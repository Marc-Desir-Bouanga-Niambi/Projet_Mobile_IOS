import SwiftUI

struct FavoritesView: View {
    @StateObject var favoritesVM: FavoritesViewModel

    var body: some View {
        NavigationStack {
            List(favoritesVM.favoriteMovies) { movie in
                NavigationLink {
                    MovieDetailView(
                        movie: movie,
                        favoritesVM: favoritesVM
                    )
                } label: {
                    MovieRowView(movie: movie)
                }
            }
            .navigationTitle("Favoris")
            .onAppear {
                favoritesVM.loadFavorites()
            }
        }
    }
}
