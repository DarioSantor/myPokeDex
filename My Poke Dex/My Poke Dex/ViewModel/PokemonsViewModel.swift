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
        var next: String?
        var results: [Pokemon]
    }
    
    @Published var pokemonsList: [Pokemon] = []
    @Published var urlString = "https://pokeapi.co/api/v2/pokemon?&limit=50"
    @Published var count = 0
    @Published var isLoading = false
    
    func getData() async {
        isLoading = true
        guard let url = URL(string: urlString) else {
            isLoading = false
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            guard let returned = try? JSONDecoder().decode(Returned.self, from: data) else {
                isLoading = false
                return
            }
            
            self.count = returned.count
            self.urlString = returned.next ?? ""
            self.pokemonsList += returned.results
            
            isLoading = false
            
        } catch {
            isLoading = false
            print("ERROR: No data from URL")
        }
    }
    
    func loadNextIfNeeded(pokemon: Pokemon) async {
        guard let lastPokemon = pokemonsList.last else {
            return
        }
        if pokemon.id == lastPokemon.id && urlString.hasPrefix("http") {
                Task {
                    await getData()
                }
            }
    }
    
    func loadAll() async {
        guard urlString.hasPrefix("http") else { return }
        
        await getData()
        
        await loadAll()
    }
}
