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
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tablaPokemon.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CellPokemonTableViewCell
        cell.namePokemon.text = "Pikachu"
        cell.attackPokemon.text = "80"
        cell.defensePokemon.text = "80"
        //cell.imagePokemon.image = UIImage(named: "bulbasaur")
        
        //FALTA AÑADIR LA IMAGEN --> ESTA INFORMACION ES ESTATICA Y NO DE LA API
        return cell
    }
    
}

extension ListaPokemonViewController: pokemonManagerDelegado{
    func mostrarListaPokemon(lista: [Pokemon]) {
    
    }
    
    
}

