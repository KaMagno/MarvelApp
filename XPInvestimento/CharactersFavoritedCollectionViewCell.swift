//
//  CharactersFavoritedCollectionViewCell.swift
//  XPInvestimento
//
//  Created by Kaique Magno Dos Santos on 26/04/18.
//  Copyright © 2018 Kaique Magno. All rights reserved.
//

import UIKit

protocol CharactersFavoritedCollectionViewCellDelegate:class {
    func didTapFavorite(value:Bool, in cell:CharactersFavoritedCollectionViewCell)
}

class CharactersFavoritedCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlet
    @IBOutlet weak var outletCharacterImage: UIImageView!
    @IBOutlet weak var outletCharacterName: UILabel!
    @IBOutlet weak var outletFavoriteButton: UIButton!
    
    // MARK: - Properties
    // MARK: Public
    weak var delegate:CharactersFavoritedCollectionViewCellDelegate?
    
    // MARK: - Init
    override func awakeFromNib() {
        self.setupViews()
    }
    
    // MARK: - Functions
    // MARK: Private
    func setupViews() {
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 10.0
        self.clipsToBounds = true
    }
    // MARK: Public
    func set(characterName:String) {
        self.outletCharacterName.text = characterName
    }
    
    func set(image:UIImage) {
        self.outletCharacterImage.image = image
        
    }
    
    func set(isFavorite:Bool) {
        self.outletFavoriteButton.isSelected = isFavorite
    }
    
    func cleanData() {
        DispatchQueue.main.async {
            self.outletCharacterName.text = "No Name"
            self.outletCharacterImage.image = nil
            self.outletFavoriteButton.isSelected = false
        }
    }
    
    // MARK: - IBActions
    @IBAction func tapFavorite(_ sender: UIButton) {
        self.delegate?.didTapFavorite(value: !sender.isSelected, in: self)
    }
}
