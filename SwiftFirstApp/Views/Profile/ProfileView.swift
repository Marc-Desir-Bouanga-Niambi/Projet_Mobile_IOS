import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var authVM: AuthViewModel

    @State private var name = ""
    @State private var email = ""
    @State private var password = ""

    var body: some View {
        VStack(spacing: 20) {

            Text("Profil")
                .font(.largeTitle)
                .bold()

            TextField("Nom", text: $name)
                .textFieldStyle(.roundedBorder)

            TextField("Email", text: $email)
                .textFieldStyle(.roundedBorder)
            
            SecureField("Nouveau mot de passe (optionnel)", text: $password)
                .textFieldStyle(.roundedBorder)


            Button("Enregistrer les modifications") {
                            authVM.updateUser(
                                name: name,
                                email: email,
                                password: password.isEmpty ? nil : password
                            )
                            password = "" // on nettoie le champ après sauvegarde
                        }
                        .buttonStyle(.borderedProminent)

            Divider()

            Button("Se déconnecter") {
                authVM.logout()
            }
            .foregroundColor(.red)

            Spacer()
        }
        .padding()
        .onAppear {
            if let user = authVM.currentUser {
                name = user.name
                email = user.email
            }
        }
    }
}
