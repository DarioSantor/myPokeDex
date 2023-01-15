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
                List(0..<pokemonsVM.pokemonsList.count, id: \.self) { index in
                    LazyVStack {
                        NavigationLink {
                            PokemonDetailView(pokemon: pokemonsVM.pokemonsList[index])
                        } label: {
                            HStack {
                                PokemonImage(imageLink: "\(pokemonsVM.pokemonsList[index].url)")
                                    .padding(.trailing, 20)
                                Text("#\(index+1)")
                                    .foregroundColor(.gray)
                                Text(pokemonsVM.pokemonsList[index].name.capitalized)
                                    .font(.title2)
                            }
                        }
                    }
                    .onAppear {
                        if let lastPokemon = pokemonsVM.pokemonsList.last {
                            if pokemonsVM.pokemonsList[index].name == lastPokemon.name && pokemonsVM.urlString.hasPrefix("http") {
                                Task {
                                    await pokemonsVM.getData()
                                }
                            }
                        }
                    }
                }
                if pokemonsVM.isLoading {
                    ProgressView()
                        .tint(.red)
                        .scaleEffect(4)
                }

            }
            .task {
                await pokemonsVM.getData()
            }
            .navigationTitle("MyPokeDex")
            }
        }
    }


struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
