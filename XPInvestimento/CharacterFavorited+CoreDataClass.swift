//
//  CharacterFavorited+CoreDataClass.swift
//  XPInvestimento
//
//  Created by Kaique Magno Dos Santos on 23/04/18.
//  Copyright © 2018 Kaique Magno. All rights reserved.
//
//

import Foundation
import CoreData

@objc(CharacterFavorited)
public class CharacterFavorited: NSManagedObject {

    required convenience public init(character:Character, in context:NSManagedObjectContext) {
        self.init(entity: CharacterFavorited.entity(), insertInto: context)
        
        self.id = character.id
        self.name = character.name
        self.characterDescription = character.description
        
        let image = CharacterImage(character: character, in: context)
        self.image = image
    }
    
}
