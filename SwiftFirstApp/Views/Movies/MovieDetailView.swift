import SwiftUI

struct MovieDetailView: View {
    let movie: Movie
    @ObservedObject var favoritesVM: FavoritesViewModel

    var isFavorite: Bool {
        favoritesVM.isFavorite(movie)
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                Text(movie.title)
                    .font(.title)
                    .bold()

                Text(movie.overview)

                Button {
                    if isFavorite {
                        favoritesVM.removeFromFavorites(movie: movie)
                    } else {
                        favoritesVM.addToFavorites(movie: movie)
                    }
                } label: {
                    HStack {
                        Image(systemName: isFavorite ? "heart.fill" : "heart")
                        Text(isFavorite ? "Retirer des favoris" : "Ajouter aux favoris")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(isFavorite ? .red : .blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                }
            }
            .padding()
        }
    }
}
