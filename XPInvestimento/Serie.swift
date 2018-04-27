//
//  Serie.swift
//  XPInvestimento
//
//  Created by Kaique Magno Dos Santos on 27/04/18.
//  Copyright © 2018 Kaique Magno. All rights reserved.
//

import UIKit

public struct Serie: Decodable {

    enum Keys:String,CodingKey {
        case name = "title"
        case thumbnail
    }
    
    let name:String?
    let thumbnail:Image?
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: Keys.self)
        self.name = try values.decodeIfPresent(String.self, forKey: .name)
        self.thumbnail = try values.decodeIfPresent(Image.self, forKey: .thumbnail)
    }
}

extension Serie:HorizontalListObject {
    func getName() -> String? {
        return self.name
    }
    func getImage() -> Image? {
        return self.thumbnail
    }
}
