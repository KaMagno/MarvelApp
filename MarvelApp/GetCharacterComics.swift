//
//  GetComics.swift
//  XPInvestimento
//
//  Created by Kaique Magno Dos Santos on 27/04/18.
//  Copyright © 2018 Kaique Magno. All rights reserved.
//

import UIKit

class GetCharacterComics: APIRequest {
    typealias Response = [Comic]
    
    var endpoint: String {
        return "characters/\(self.characterId)/comics"
    }
    
    // Parameters
    let characterId:Int
    
    init(characterId:Int) {
        self.characterId = characterId
    }
}

