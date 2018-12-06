//
//  GetCharacterSeries.swift
//  XPInvestimento
//
//  Created by Kaique Magno Dos Santos on 27/04/18.
//  Copyright © 2018 Kaique Magno. All rights reserved.
//

import UIKit

class GetCharacterSeries: APIRequest {
    typealias Response = [Serie]
    
    var endpoint: String {
        return "characters/\(self.characterId)/series"
    }
    
    // Parameters
    let characterId:Int
    
    init(characterId:Int) {
        self.characterId = characterId
    }
}
