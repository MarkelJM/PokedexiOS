//
//  CellPokemonTableViewCell.swift
//  Pokedex
//
//  Created by Markel Juaristi on 4/1/23.
//

import UIKit

class CellPokemonTableViewCell: UITableViewCell {

    @IBOutlet weak var defensePokemon: UILabel!
    @IBOutlet weak var attackPokemon: UILabel!
    @IBOutlet weak var namePokemon: UILabel!
    @IBOutlet weak var imagePokemon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        imagePokemon.layer.cornerRadius = 20
    }
    
}
