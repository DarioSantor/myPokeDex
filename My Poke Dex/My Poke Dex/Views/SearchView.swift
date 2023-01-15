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
        NavigationStack {
            ZStack {
                List(searchResults) { pokemon in
                    LazyVStack {
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
                    }
                    .onAppear {
                        Task {
                            await pokemonsVM.loadNextIfNeeded(pokemon: pokemon)
                        }
                    }
                }
                if pokemonsVM.isLoading {
                    ProgressView()
                        .tint(.orange)
                        .scaleEffect(4)
                }
            }
            .searchable(text: $searchText)
            .task {
                await pokemonsVM.getData()
            }
            .navigationTitle("MyPokeDex")
            .toolbar {
                ToolbarItem (placement: .navigationBarTrailing) {
                    Button("Load all") {
                        Task {
                            await pokemonsVM.loadAll()
                        }
                    }
                }
            }
            }
        }
    var searchResults: [Pokemon] {
        if searchText.isEmpty {
            return pokemonsVM.pokemonsList
        } else {
            return pokemonsVM.pokemonsList.filter { $0.name.capitalized.contains(searchText) }
        }
    }
    }


struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
