import SwiftUI

struct FavoritesView: View {
    @StateObject var favoritesVM: FavoritesViewModel

    var body: some View {
        List(favoritesVM.favoriteMovies) { movie in
            MovieRowView(movie: movie)
        }
        .onAppear {
            favoritesVM.loadFavorites()
        }
    }
}
