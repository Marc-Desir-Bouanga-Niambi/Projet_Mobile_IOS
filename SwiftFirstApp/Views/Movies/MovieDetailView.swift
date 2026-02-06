import SwiftUI

struct MovieDetailView: View {
    let movie: Movie
    @Binding var favoriteMovieIds: [Int] // liste des favoris de l'utilisateur connecté

    var isFavorite: Bool {
        favoriteMovieIds.contains(movie.id)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Image
                Image(systemName: "film") // placeholder
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
                    .cornerRadius(12)
                    .background(Color.gray.opacity(0.3))

                // Titre
                Text(movie.title)
                    .font(.title)
                    .bold()

                // Note
                Text("Note : \(movie.rating, specifier: "%.1f")")
                    .font(.headline)
                    .foregroundColor(.orange)

                // Description
                Text(movie.overview)
                    .font(.body)

                // Bouton Favori
                Button(action: {
                    toggleFavorite()
                }) {
                    HStack {
                        Image(systemName: isFavorite ? "heart.fill" : "heart")
                        Text(isFavorite ? "Retirer des favoris" : "Ajouter aux favoris")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(isFavorite ? Color.red : Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                }

            }
            .padding()
        }
        .navigationTitle("Détail")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func toggleFavorite() {
        if isFavorite {
            favoriteMovieIds.removeAll { $0 == movie.id }
        } else {
            favoriteMovieIds.append(movie.id)
        }
    }
}
