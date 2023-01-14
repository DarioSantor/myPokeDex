//
//  PokemonDetailViewModel.swift
//  My Poke Dex
//
//  Created by Santos, Dario Ferreira on 14/01/2023.
//

import Foundation

@MainActor
class PokemonDetailViewModel: ObservableObject {
    
    private struct Returned: Codable {
        var height: Int
        var weight: Int
        var sprites: Sprite
    }
    
    struct Sprite: Codable {
        var front_default: String
    }
    
    var urlString = ""
    @Published var height = 0
    @Published var weight = 0
    @Published var imageURL = ""
    
    func getData() async {
        guard let url = URL(string: urlString) else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            guard let returned = try? JSONDecoder().decode(Returned.self, from: data) else { return }
            
            self.height = returned.height
            self.weight = returned.weight
            self.imageURL = returned.sprites.front_default
            
        } catch {
            print("ERROR: No data from URL")
        }
    }
}

