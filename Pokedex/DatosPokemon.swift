//
//  DatosPokemon.swift
//  Pokedex
//
//  Created by Markel Juaristi on 4/1/23.
//

import Foundation

struct Pokemon: Decodable, Identifiable {
    let id: Int
    let attack: Int
    let name: String
    let imageUrl: String
    let defense: Int
    let description: String
    let type: String
}
