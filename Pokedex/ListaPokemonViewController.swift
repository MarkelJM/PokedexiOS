//
//  ViewController.swift
//  Pokedex
//
//  Created by Markel Juaristi on 4/1/23.
//

import UIKit

class ListaPokemonViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var searchBarPokemon: UINavigationItem!
    @IBOutlet weak var tablaPokemon: UITableView!
    
    var pokemonManager = PokemonManager()
    
    var pokemons: [Pokemon] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokemonManager.delegado = self
        tablaPokemon.register(UINib(nibName: "CellPokemonTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
                    
        
        tablaPokemon.delegate = self
        tablaPokemon.dataSource = self
        
        //ejecutar el metodo para buscar la lista dede pokemon en la api
        pokemonManager.verPokemon()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tablaPokemon.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CellPokemonTableViewCell
        cell.namePokemon.text = pokemons[indexPath.row ].name
        cell.attackPokemon.text = "Attack: \(pokemons[indexPath.row].attack)"
        cell.defensePokemon.text = "Defense: \(pokemons[indexPath.row].defense)"
        //cell.imagePokemon.image = UIImage(named: "bulbasaur")
        
        //FALTA AÑADIR LA IMAGEN --> ESTA INFORMACION ES ESTATICA Y NO DE LA API
        if let urlString = pokemons[indexPath.row].imageUrl as? String{
            /* si tenemos una imagen debemos crear un objeto de imagen (lo de abajo)*/
            if let imageURL = URL(string: urlString){
                DispatchQueue.global().async {
                    guard let imageData = try? Data(contentsOf: imageURL) else {
                        return}
                    let image = UIImage(data: imageData)
                    DispatchQueue.main.async {
                        cell.imagePokemon.image = image
                    }
                }
            }
        }
        return cell
    }
    
}
/* metodo para llenar la app con informacion de la API*/
extension ListaPokemonViewController: pokemonManagerDelegado{
    func mostrarListaPokemon(lista: [Pokemon]) {
        pokemons = lista
        
        DispatchQueue.main.async {
            self.tablaPokemon.reloadData()
        }
    
    }
    
    
}

