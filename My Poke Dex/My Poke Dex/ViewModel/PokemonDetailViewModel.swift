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
        var height: Int?
        var weight: Int?
        var sprites: Sprite
        let stats: [StatElement]
    }
    
    struct StatElement: Codable {
        let base_stat: Int
    }
    
    struct Sprite: Codable {
        var front_default: String?
        var other: Other
    }

    struct Other: Codable {
        var officialArtwork: OfficialArtwork
        
        enum CodingKeys: String, CodingKey {
            case officialArtwork = "official-artwork"
        }
    }
    
    struct OfficialArtwork: Codable {
        var front_default: String?
    }
    
    var urlString = ""
    @Published var height = 0
    @Published var weight = 00
    @Published var imageURL = ""
    @Published var stats = [StatElement(base_stat: 0), StatElement(base_stat: 0), StatElement(base_stat: 0)]
    
    func getData() async {
        guard let url = URL(string: urlString) else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            guard let returned = try? JSONDecoder().decode(Returned.self, from: data) else { return }
            
            self.height = returned.height ?? 0
            self.weight = returned.weight ?? 0
            self.imageURL = returned.sprites.other.officialArtwork.front_default ?? "n/a"
            self.stats = returned.stats
            
        } catch {
            print("ERROR: No data from URL")
        }
    }
}

