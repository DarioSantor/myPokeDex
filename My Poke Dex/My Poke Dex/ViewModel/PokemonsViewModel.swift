//
//  PokemonsViewModel.swift
//  My Poke Dex
//
//  Created by Santos, Dario Ferreira on 14/01/2023.
//

import Foundation

class PokemonsViewModel: ObservableObject {
    
    private struct Returned: Codable {
        var count: Int
        var next: String
    }
    
    var urlString = "https://pokeapi.co/api/v2/pokemon?limit=151"
    
    func getData() async {
        guard let url = URL(string: urlString) else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            guard let returned = try? JSONDecoder().decode(Returned.self, from: data) else { return }
            
        } catch {
            print("ERROR: No data from URL")
        }
    }
}
