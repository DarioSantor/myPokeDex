//
//  PokemonDetailView.swift
//  My Poke Dex
//
//  Created by Santos, Dario Ferreira on 14/01/2023.
//

import SwiftUI

struct PokemonDetailView: View {
    let pokemon: PokemonEntry
    
    var body: some View {
        VStack {
            PokemonImage(imageLink: "\(pokemon.url)")
            
            Text("\(pokemon.name)".capitalized)
                .font(.title)
        }
    }
}

