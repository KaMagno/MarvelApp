//
//  HorizontalListCollectionViewCell.swift
//  MarvelApp
//
//  Created by Kaique Magno Dos Santos on 27/04/18.
//  Copyright © 2018 Kaique Magno. All rights reserved.
//

import UIKit

class HorizontalListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var outletImage: UIImageView!
    @IBOutlet weak var outletTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setupViewLayout()
    }
    
    func setupViewLayout() {
        self.contentView.backgroundColor = .white
        self.contentView.layer.cornerRadius = 10.0
        self.contentView.layer.borderWidth = 2.0
        self.contentView.layer.borderColor = UIColor.black.cgColor
        
        let ratio:CGFloat = 0.90
        let rect = CGRect(x: (self.bounds.width*(1-ratio))/2, y: (self.bounds.height*(1-ratio))/2, width: self.bounds.width*ratio, height: self.bounds.height*ratio)
        self.layer.shadowPath = UIBezierPath(roundedRect: rect, cornerRadius: self.contentView.layer.cornerRadius).cgPath
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: -8.0, height: 0.0)
        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = 5
        self.layer.masksToBounds = false
        
        self.contentView.clipsToBounds = true
    }
}
