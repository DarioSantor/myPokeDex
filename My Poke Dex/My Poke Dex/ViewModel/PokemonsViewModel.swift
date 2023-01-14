//
//  PokemonsViewModel.swift
//  My Poke Dex
//
//  Created by Santos, Dario Ferreira on 14/01/2023.
//

import Foundation

@MainActor
class PokemonsViewModel: ObservableObject {
    
    private struct Returned: Codable {
        var count: Int
        var next: String
        var results: [Pokemon]
    }
    
    @Published var pokemonsList: [Pokemon] = []
    @Published var urlString = "https://pokeapi.co/api/v2/pokemon?limit=151"
    @Published var count = 0
    
    func getData() async {
        guard let url = URL(string: urlString) else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            guard let returned = try? JSONDecoder().decode(Returned.self, from: data) else { return }
            self.count = returned.count
            self.urlString = returned.next
            self.pokemonsList = returned.results
            
        } catch {
            print("ERROR: No data from URL")
        }
    }
}
