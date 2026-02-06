import SwiftUI

struct RegisterView: View {
    
    @EnvironmentObject var authVM: AuthViewModel
    
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        VStack(spacing: 20) {
            
            Text("Inscription")
                .font(.largeTitle)
                .bold()
            
            TextField("Nom", text: $name)
                .textFieldStyle(.roundedBorder)
            
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
            
            Button("Créer le compte") {
                authVM.register(
                    name: name,
                    email: email,
                    password: password
                )
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}
