//
//  CharacterFavorited+CoreDataProperties.swift
//  XPInvestimento
//
//  Created by Kaique Magno Dos Santos on 23/04/18.
//  Copyright © 2018 Kaique Magno. All rights reserved.
//
//

import Foundation
import CoreData

extension CharacterFavorited {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CharacterFavorited> {
        return NSFetchRequest<CharacterFavorited>(entityName: "CharacterFavorited")
    }

    @NSManaged public var characterDescription: String?
    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var image: CharacterImage?

}

