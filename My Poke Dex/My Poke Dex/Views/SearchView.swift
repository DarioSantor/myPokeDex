//
//  SearchView.swift
//  My Poke Dex
//
//  Created by Santos, Dario Ferreira on 12/01/2023.
//

import SwiftUI

struct SearchView: View {
    @StateObject var pokemonsVM = PokemonsViewModel()
    @State var searchText = ""
    
    var body: some View {
        NavigationView {
            List(pokemonsVM.pokemonsList, id: \.self) {
                pokemon in
                NavigationLink {
                    PokemonDetailView(pokemon: pokemon)
                } label: {
                    HStack {
                        PokemonImage(imageLink: "\(pokemon.url)")
                            .padding(.trailing, 20)
                        Text(pokemon.name.capitalized)
                            .font(.title2)
                    }
                }
                .searchable(text: $searchText)
            }
            .task {
                await pokemonsVM.getData()
            }
            .navigationTitle("Search")
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
