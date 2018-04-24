//
//  CharactersCollectionViewCell.swift
//  XPInvestimento
//
//  Created by Kaique Magno Dos Santos on 22/04/18.
//  Copyright © 2018 Kaique Magno. All rights reserved.
//

import UIKit

protocol CharactersCollectionViewCellDelegate:class {
    func didTapFavorite(in frame:CGRect)
}

class CharactersCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlet
    @IBOutlet weak var outletCharacterImage: UIImageView!
    @IBOutlet weak var outletCharacterName: UILabel!
    @IBOutlet weak var outletFavoriteButton: UIButton!
    
    // MARK: - Properties
    // MARK: Public
    weak var delegate:CharactersCollectionViewCellDelegate?
    
    // MARK: - Init
    override func awakeFromNib() {
        self.contentView.layer.borderColor = UIColor.gray.cgColor
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.cornerRadius = 10.0
    }
    
    // MARK: - Functions
    // MARK: Public
    func set(characterName:String) {
        self.outletCharacterName.text = characterName
    }
    
    func set(characterImageURL:URL) {
        ImageManager.shared.fetchImage(from: characterImageURL) { (image, error) in
            DispatchQueue.main.async {
                if let imageVerified = image {
                    self.outletCharacterImage.image = imageVerified
                } else {
                    self.outletCharacterImage.image = #imageLiteral(resourceName: "Nil")
                }
            }
        }
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
        self.delegate?.didTapFavorite(in: self.frame)
    }
}
