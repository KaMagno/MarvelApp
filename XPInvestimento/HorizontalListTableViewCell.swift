//
//  HorizontalListTableViewCell.swift
//  XPInvestimento
//
//  Created by Kaique Magno Dos Santos on 26/04/18.
//  Copyright © 2018 Kaique Magno. All rights reserved.
//

import UIKit

class HorizontalListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView:UICollectionView!
    
    var presenter:HorizontalListPresenter?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupFlowLayout()
    }
    
    func setupFlowLayout()  {
        guard let flowLayout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            Logger.logError(in: self, message: "Could not cast to UICollectionViewFlowLayout")
            return
        }
        
        let width = self.contentView.bounds.width
        let height = self.contentView.bounds.height
        
        let sizeRatio:CGFloat = 0.8
        let edgeRatio:CGFloat = 1 - sizeRatio
        
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: height*0.8, height: height*0.8)
        flowLayout.minimumLineSpacing = width*0.1
        flowLayout.sectionInset = UIEdgeInsets(top: height*edgeRatio, left: height*edgeRatio, bottom: height*edgeRatio, right: height*edgeRatio)
    }
}
