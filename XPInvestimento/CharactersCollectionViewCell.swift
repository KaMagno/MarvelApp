//
//  CharactersCollectionViewCell.swift
//  XPInvestimento
//
//  Created by Kaique Magno Dos Santos on 22/04/18.
//  Copyright © 2018 Kaique Magno. All rights reserved.
//

import UIKit

protocol CharactersCollectionViewCellDelegate:class {
    func didTapFavorite(value:Bool, in cell:CharactersCollectionViewCell)
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
        self.setupViews()
    }
    
    // MARK: - Functions
    // MARK: Private
    func setupViews() {
        self.contentView.layer.borderColor = UIColor.gray.cgColor
        self.contentView.layer.borderWidth = 2.0
        self.contentView.layer.cornerRadius = 10.0
        
        
        let ratio:CGFloat = 0.90
        let rect = CGRect(x: (self.bounds.width*(1-ratio))/2, y: (self.bounds.height*(1-ratio))/2, width: self.bounds.width*ratio, height: self.bounds.height*ratio)
        self.layer.shadowPath = UIBezierPath(roundedRect: rect, cornerRadius: self.contentView.layer.cornerRadius).cgPath
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = CGSize(width: -8.0, height: 0.0)
        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = 5
        self.layer.masksToBounds = false
        
        self.contentView.clipsToBounds = true
    }
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
        self.delegate?.didTapFavorite(value: !sender.isSelected, in: self)
    }
}
