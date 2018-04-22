//
//  Character.swift
//  XPInvestimento
//
//  Created by Kaique Magno Dos Santos on 21/04/18.
//  Copyright © 2018 Kaique Magno. All rights reserved.
//

import UIKit

struct Character: Decodable {
    let id: Int
    let name: String?
    let description: String?
    let thumbnail: Image?
    
    public init(id: Int = 0,
                name: String? = nil,
                description: String? = nil,
                thumbnail: Image? = nil) {
        self.id = id
        self.name = name
        self.description = description
        self.thumbnail = thumbnail
    }
}
