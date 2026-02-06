import SwiftUI

struct ProfileView: View {

    @EnvironmentObject var authVM: AuthViewModel

    var body: some View {
        VStack(spacing: 20) {

            // Nom
            Text(authVM.currentUser?.name ?? "Utilisateur inconnu")
                .font(.title)
                .bold()

            // Email
            Text(authVM.currentUser?.email ?? "")
                .foregroundColor(.gray)

            Spacer()

            // Bouton Déconnexion
            Button(role: .destructive) {
                authVM.logout()
            } label: {
                Text("Se déconnecter")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)

        }
        .padding()
        .navigationTitle("Profil")
    }
}
