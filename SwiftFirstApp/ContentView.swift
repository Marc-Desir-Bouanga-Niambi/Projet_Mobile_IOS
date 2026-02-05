//
//  ContentView.swift
//  SwiftFirstApp
//
//  Created by Keliane Serane Moayé Kossa on 04/02/2026.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var email: String = ""
    @State private var password = ""
    @State private var name: String = ""

    var body: some View {
        NavigationView {
            LoginSwift(email: $email, password: $password, name: $name)
        }
       
       
    }
}

#Preview {
    ContentView()
}
