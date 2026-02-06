import SwiftUI

struct MovieRowView: View {
    let movie: Movie
    
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            // Image placeholder
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
                        .resizable()
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

            
            VStack(alignment: .leading, spacing: 5) {
                Text(movie.title)
                    .font(.headline)
                Text("Note : \(movie.vote_average, specifier: "%.1f")")
                    .font(.subheadline)
                    .foregroundColor(.orange)
            }
        }
        .padding(.vertical, 5)
    }
}
