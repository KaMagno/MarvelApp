//
//  ChactersCollectionReusableView.swift
//  XPInvestimento
//
//  Created by Kaique Magno Dos Santos on 25/04/18.
//  Copyright © 2018 Kaique Magno. All rights reserved.
//

import UIKit

class CharactersCollectionReusableView: UICollectionReusableView {
        
    @IBOutlet weak var outletSearchBar: UISearchBar!
    
    override func awakeFromNib() {
        self.outletSearchBar.setScopeBarButtonTitleTextAttributes([
            NSAttributedStringKey.font.rawValue: UIFont(name: "Impact", size: 15.0) ?? UIFont.systemFont(ofSize: 17.0),
            NSAttributedStringKey.foregroundColor.rawValue: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
            ], for: UIControlState.normal)
        
        self.outletSearchBar.tintColor = .white
    }
}
