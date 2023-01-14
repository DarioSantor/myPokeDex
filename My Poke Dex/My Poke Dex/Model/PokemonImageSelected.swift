//
//  PokemonImageSelected.swift
//  My Poke Dex
//
//  Created by Santos, Dario Ferreira on 13/01/2023.
//

import Foundation

struct PokemonImageSelected: Codable {
    var sprites: PokemonSprites
}

struct PokemonSprites: Codable {
    var front_default: String?
}

@MainActor
class PokemonImageSelectedApi {
    func getData(url: String, completion: @escaping (PokemonSprites) -> ()) {
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            
            let pokemonSprite = try! JSONDecoder().decode(PokemonImageSelected.self, from: data)
            
            DispatchQueue.main.async {
                completion(pokemonSprite.sprites)
            }
        }.resume()
    }
}
