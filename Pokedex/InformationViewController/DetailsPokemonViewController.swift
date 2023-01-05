//
//  DetailsPokemonViewController.swift
//  Pokedex
//
//  Created by Markel Juaristi on 5/1/23.
//

import UIKit

class DetailsPokemonViewController: UIViewController {
    
    var pokemonShow: Pokemon?
    
    @IBOutlet weak var defensaPokemon: UILabel!
    @IBOutlet weak var ataquePokemon: UILabel!
    @IBOutlet weak var tipoPokemon: UILabel!
    @IBOutlet weak var descriptionPokemon: UITextView!
    @IBOutlet weak var imagenPokemon: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tipoPokemon.text = " Tipo :  \(pokemonShow?.type ?? "")"
        ataquePokemon.text = "Ataque: \(pokemonShow!.attack )"
        defensaPokemon.text = "Defensa: \(pokemonShow!.defense )"
        descriptionPokemon.text = pokemonShow?.description ?? ""
        
        //Imagen
        imagenPokemon.loadFrom(URLAddress: pokemonShow?.imageUrl ?? "")
        
        

        
    }

}

extension UIImageView{
    func loadFrom(URLAddress: String){
        guard let url = URL(string: URLAddress) else {return}
        
        DispatchQueue.main.async { [weak self] in
            if let imageData = try? Data(contentsOf:  url){
                if let loadedImage = UIImage(data: imageData){
                    self?.image = loadedImage
                }
            }
        }
    }
}
