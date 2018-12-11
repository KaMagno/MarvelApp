//
//  DescriptionInteractor.swift
//  XPInvestimento
//
//  Created by Kaique Magno Dos Santos on 26/04/18.
//  Copyright © 2018 Kaique Magno. All rights reserved.
//

import UIKit

class DescriptionInteractor: NSObject {

    var image:Thumbnail?
    var text:String
    
    init(image:Thumbnail?, text:String) {
        self.image = image
        self.text = text
    }
}


