//
//  Pokemon.swift
//  My Poke Dex
//
//  Created by Santos, Dario Ferreira on 14/01/2023.
//

import Foundation

struct Pokemon: Codable, Identifiable {
    let id = UUID().uuidString
    var name: String
    var url: String
    
    enum CodingKeys: CodingKey {
        case name, url
    }
}
