//
//  ContentView.swift
//  My Poke Dex
//
//  Created by Santos, Dario Ferreira on 12/01/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
            FavouritesView()
                .tabItem {
                    Image(systemName: "heart")
                    Text("Favourites")
                }
        } 
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
