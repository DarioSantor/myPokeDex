//
//  PokemonImage.swift
//  My Poke Dex
//
//  Created by Santos, Dario Ferreira on 13/01/2023.
//

import SwiftUI

struct PokemonImage: View {
    var imageLink = ""
    @State private var pokemonSprite = ""
    
    var body: some View {
        AsyncImage(url: URL(string: pokemonSprite))
            .frame(width: 75, height: 75)
            .onAppear {
                let loadedData = UserDefaults.standard.string(forKey: imageLink)
                
                if loadedData == nil {
                    getSprite(url: imageLink)
                    UserDefaults.standard.set(imageLink, forKey: imageLink)
                } else {
                    getSprite(url: loadedData!)
                }
            }
            .clipShape(Circle())
            .foregroundColor(Color.gray.opacity(0.90))
    }
    
    @MainActor 
    func getSprite(url: String) {
        var tempSprite: String?
        
        PokemonImageSelectedApi().getData(url: url) { sprite in
            tempSprite = sprite.front_default
            self.pokemonSprite = tempSprite ?? "placeholder"
        }
        
    }
}

struct PokemonImage_Previews: PreviewProvider {
    static var previews: some View {
        PokemonImage()
    }
}
