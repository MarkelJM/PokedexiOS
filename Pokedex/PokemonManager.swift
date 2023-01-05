//
//  PokemonManager.swift
//  Pokedex
//
//  Created by Markel Juaristi on 4/1/23.
//

import Foundation

protocol pokemonManagerDelegado {
    func mostrarListaPokemon(lista: [Pokemon])
}

struct PokemonManager {
    var delegado: pokemonManagerDelegado?
    
    func verPokemon() {
        let urlString = "https://pokedex-bb36f.firebaseio.com/pokemon.json"
        
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            
            let tarea = session.dataTask(with: url) {datos, respuesta, error in
                if error != nil{
                    print("error al obtener datos de API",error?.localizedDescription)
                    
                }
                if let datosSeguros = datos?.parseData(quitarString: "null,")  {
                    if let listaPokemon = self.parsearJSON(datosPokemon: datosSeguros){
                        print("Lista de Pokemon: ", listaPokemon)
                        delegado?.mostrarListaPokemon(lista: listaPokemon)
                    }
                    
                }
                
                
            }
            tarea.resume()
        }
        

    }
    func parsearJSON(datosPokemon: Data)-> [Pokemon]? {
        let decodificador = JSONDecoder()
        do{
            let datosDecodificados = try decodificador.decode([Pokemon].self, from: datosPokemon)
            return datosDecodificados
        }catch{
            print("error al decodificar datos: ",error.localizedDescription)
            return nil
        }
    }
}


extension Data {
    func parseData(quitarString palabra: String) -> Data? {
        let dataAsString = String(data: self, encoding: .utf8)
        let parseDataString = dataAsString?.replacingOccurrences(of: palabra, with: "")
        guard let data = parseDataString?.data(using: .utf8) else {return nil}
        return data
    }
}
