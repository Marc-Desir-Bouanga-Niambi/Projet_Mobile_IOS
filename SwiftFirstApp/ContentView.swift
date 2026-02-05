//
//  ContentView.swift
//  SwiftFirstApp
//
//  Created by Keliane Serane Moayé Kossa on 04/02/2026.
//

import SwiftUI
import SwiftData

struct ContentView: View {

    var body: some View {
        NavigationStack {
            TabView {
                MovieListView()
                    .tabItem {
                        Label("Films", systemImage: "film")
                    }
                FavoritesView()
                    .tabItem {
                        Label("Favoris", systemImage: "heart")
                    }
                                
                ProfileView()
                    .tabItem {
                        Label("Profil", systemImage: "person")
                    }
                
            }
            
            
        }
       
       
    }
}

#Preview {
    ContentView()
}
