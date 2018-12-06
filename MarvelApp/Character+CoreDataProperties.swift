//
//  Character+CoreDataProperties.swift
//  XPInvestimento
//
//  Created by Kaique Magno Dos Santos on 28/04/18.
//  Copyright © 2018 Kaique Magno. All rights reserved.
//
//

import Foundation
import CoreData


extension Character {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Character> {
        return NSFetchRequest<Character>(entityName: "Character")
    }

    @NSManaged public var characterDescription: String?
    @NSManaged public var id: Int32
    @NSManaged public var isFavorited: Bool
    @NSManaged public var name: String?
    @NSManaged public var thumbnail: Thumbnail?

}
