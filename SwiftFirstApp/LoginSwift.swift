//
//  Item.swift
//  SwiftFirstApp
//
//  Created by Keliane Serane Moayé Kossa on 04/02/2026.
//

import SwiftUI
import SwiftData

struct LoginSwift: View {
    @Binding var email: String
    @Binding var password: String
    @Binding var name : String
    @State private var isPasswordVisible: Bool = false
    var body: some View {
        VStack(spacing: 40) {
            // Titre
//            Text("Stream App")
//                .font(.largeTitle)
//                .padding(.bottom,20)
//                .bold(true)
            Text("Se connecter")
                .font(.largeTitle)
                .padding(.bottom,10)
                .bold(true)
            
            // Champ Email
            VStack(alignment: .leading) {
                Text("Email")
                    .font(.caption)
                    .foregroundColor(.gray)
                TextField("exemple@mail.com", text: $email)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                   
            }
            
            // Champ Mot de passe
            VStack(alignment: .leading) {
                Text("Mot de passe")
                    .font(.caption)
                    .foregroundColor(.gray)
                HStack{
                    if isPasswordVisible{
                        TextField("********", text: $password)
                    }else{
                        SecureField("********", text: $password)
                }
                    Button(action: {
                        isPasswordVisible.toggle()
                    }) {
                        Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                            .foregroundColor(.gray)
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)

            }
            
            // Bouton de connexion
            Button(action: {
                print("Login avec \(email)")
            }) {
                Text("Se connecter")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(email.isEmpty || password.count < 6 ? Color.gray : Color.brown
                        )
                    .cornerRadius(12)
            }
            .disabled(email.isEmpty || password.count < 6) // Désactive si incomplet
            
            NavigationLink(destination: Register(email: $email,password: $password, name: $name)) {
                Text("Pas de compte ? Inscrivez-vous")
                    .font(.subheadline)
                    .foregroundColor(.blue)
            }
            

        }
        .padding(30)
    }
    
    
}






