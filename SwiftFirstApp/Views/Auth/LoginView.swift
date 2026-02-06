import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var authVM: AuthViewModel
    
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        VStack(spacing: 20) {
            
            Text("Connexion")
                .font(.largeTitle)
                .bold()
            
            TextField("Email", text: $email)
                .textInputAutocapitalization(.never)
                .keyboardType(.emailAddress)
                .textFieldStyle(.roundedBorder)
            
            SecureField("Mot de passe", text: $password)
                .textFieldStyle(.roundedBorder)
            
            if let error = authVM.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .font(.caption)
            }
            
            Button("Se connecter") {
                authVM.login(email: email, password: password)
            }
            .buttonStyle(.borderedProminent)
            
            NavigationLink("Créer un compte", destination: RegisterView())
        }
        .padding()
    }
}
