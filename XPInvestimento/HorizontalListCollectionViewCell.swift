//
//  HorizontalListCollectionViewCell.swift
//  XPInvestimento
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
        self.contentView.layer.cornerRadius = 10.0
        self.contentView.layer.borderWidth = 2.0
        self.contentView.layer.borderColor = UIColor.black.cgColor
        
        self.contentView.layer.shadowColor = UIColor.darkGray.cgColor
        self.contentView.layer.shadowRadius = 5.0
    }
}
