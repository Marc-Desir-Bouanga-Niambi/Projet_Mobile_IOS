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

                AsyncImage(url: movie.posterURL!) { phase in
                    switch phase {
                    case .empty:
                        // Placeholder pendant le téléchargement
                        Color.gray.opacity(0.3)
                            .frame(width: 60, height: 90)
                            .cornerRadius(8)
                    case .success(let image):
                        // Image chargée avec succès
                        image
                            .resizable()           // <- Ici, sur l'objet Image
                            .scaledToFill()
                            .frame(width: 60, height: 90)
                            .cornerRadius(8)
                    case .failure:
                        // Image a échoué à charger
                        Color.red
                            .frame(width: 60, height: 90)
                            .cornerRadius(8)
                    @unknown default:
                        EmptyView()
                    }
                }
        
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
