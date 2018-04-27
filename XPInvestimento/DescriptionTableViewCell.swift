//
//  DescriptionTableViewCell.swift
//  XPInvestimento
//
//  Created by Kaique Magno Dos Santos on 26/04/18.
//  Copyright © 2018 Kaique Magno. All rights reserved.
//

import UIKit

class DescriptionTableViewCell: UITableViewCell {

    @IBOutlet weak var outletImage: UIImageView!
    @IBOutlet weak var outletDescription: UILabel!
    
    var presenter:DescriptionPresenter!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.presenter.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
