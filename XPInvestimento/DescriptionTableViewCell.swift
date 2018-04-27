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
    @IBOutlet weak var outletBackgroundDescriptionView: UIView!
    
    var presenter:DescriptionPresenter?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setupLayout()
    }

    private func setupLayout() {
        self.outletBackgroundDescriptionView.isHidden = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    func set(description:String) {
        self.outletBackgroundDescriptionView.isHidden = description.isEmpty
        self.outletDescription.text = description
    }
    
    func set(image:Image) {
        ImageManager.shared.fetchImage(from: image.url) { (fetchedImage, error) in
            if let fetchedImageVerified = fetchedImage {
                DispatchQueue.main.async {
                    self.outletImage.image = fetchedImageVerified
                }
            }else if let errorVerified = error {
                Logger.logError(in: self, message: errorVerified.localizedDescription)
            }
        }
    }
}
