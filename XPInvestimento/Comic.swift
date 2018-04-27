//
//  Comic.swift
//  XPInvestimento
//
//  Created by Kaique Magno Dos Santos on 27/04/18.
//  Copyright © 2018 Kaique Magno. All rights reserved.
//

import UIKit

struct Comic:Codable {

    let name:String
    let image:UIImage
}

extension Comic:HorizontalListObject {
    func getName() -> String {
        return self.name
    }
    func getImage() -> UIImage {
        return self.image
    }
}
