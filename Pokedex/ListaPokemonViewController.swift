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
    
    var pokemonSelected: Pokemon?
    
    var pokemonFilter: [Pokemon] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokemonManager.delegado = self
        tablaPokemon.register(UINib(nibName: "CellPokemonTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
                    
        //searchBarPokemon.delegate = self
        /* No consigo que que la barra de búsqueda funcione*/
        tablaPokemon.delegate = self
        tablaPokemon.dataSource = self
        tablaPokemon.estimatedRowHeight = 10
        
        //ejecutar el metodo para buscar la lista dede pokemon en la api
        pokemonManager.verPokemon()
        
        

        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonFilter.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tablaPokemon.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CellPokemonTableViewCell
        cell.namePokemon.text = pokemonFilter[indexPath.row ].name
        cell.attackPokemon.text = "Attack: \(pokemonFilter[indexPath.row].attack)"
        cell.defensePokemon.text = "Defense: \(pokemonFilter[indexPath.row].defense)"
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
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pokemonSelected = pokemonFilter[indexPath.row]
        performSegue(withIdentifier: "verPokemon", sender: self)
        //Deseleccionar
        tablaPokemon.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "verPokemon" {
            let verPokemon = segue.destination as! DetailsPokemonViewController
            verPokemon.pokemonShow = pokemonSelected
        }
    }
}

extension ListaPokemonViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        pokemonFilter = []
        
        if searchText == "" {
            pokemonFilter = pokemons
        } else {
            for poke in pokemons {
                if poke.name.lowercased().contains(searchText.lowercased()){
                    pokemonFilter.append(poke)
                }
            }
        }
        self.tablaPokemon.reloadData()
    }
}



/* metodo para llenar la app con informacion de la API*/
extension ListaPokemonViewController: pokemonManagerDelegado{
    func mostrarListaPokemon(lista: [Pokemon]) {
        pokemons = lista
        
        DispatchQueue.main.async {
            self.pokemonFilter = self.pokemons
            self.tablaPokemon.reloadData()
        }
    
    }
    
    
}

