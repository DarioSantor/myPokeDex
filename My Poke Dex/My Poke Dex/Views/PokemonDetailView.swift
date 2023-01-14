//
//  PokemonDetailView.swift
//  My Poke Dex
//
//  Created by Santos, Dario Ferreira on 14/01/2023.
//

import SwiftUI

struct PokemonDetailView: View {
    @StateObject var pokemonDetailVM = PokemonDetailViewModel()
    var pokemon: Pokemon
    var body: some View {
        VStack {
            Text(pokemon.name.capitalized)
                .font(.largeTitle)
                .bold()
            HStack {
                VStack {
                    Text(String(pokemonDetailVM.height))
                        .font(.title)
                        .bold()
                    Text("Height")
                        .bold()
                        .foregroundColor(.red)
                }
                .padding()
                VStack {
                    Text(String(pokemonDetailVM.weight))
                        .font(.title)
                        .bold()
                    Text("Weight")
                        .bold()
                        .foregroundColor(.red)
                }
                .padding()
            }
            .padding()
        }
        .task {
            pokemonDetailVM.urlString = pokemon.url
            await pokemonDetailVM.getData()
        }
    }
}

struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailView(pokemon: Pokemon(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/"))
    }
}
