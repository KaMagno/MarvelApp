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
        let entity = CharacterFavorited.entity()
        self.init(entity: entity, insertInto: context)
        
        self.id = Int32(character.id)
        self.name = character.name
        self.characterDescription = character.description
        
        // FIXME: Load Image to CoreData
//        let image = CharacterImage(character: character, in: context)
//        self.image = image
    }
    
}
