import SwiftUI

struct MovieListView: View {
    @StateObject private var vm = MovieListViewModel()
    @State private var favoriteMovieIds: [Int] = [] // favoris mockés pour tester

    var body: some View {
        NavigationStack {
            List(vm.movies) { movie in
                NavigationLink(
                    destination: MovieDetailView(movie: movie, favoriteMovieIds: $favoriteMovieIds)
                ) {
                    MovieRowView(movie: movie)
                }
            }
            .navigationTitle("Films")
            .onAppear { vm.loadMovies() }
            .alert(isPresented: Binding<Bool>(
                get: { vm.errorMessage != nil },
                set: { newValue in if !newValue { vm.errorMessage = nil } }
            )) {
                Alert(
                    title: Text("Erreur"),
                    message: Text(vm.errorMessage ?? "Une erreur est survenue."),
                    dismissButton: .default(Text("OK"), action: { vm.errorMessage = nil })
                )
            }
        }
    }
}
