//
//  FavoriteCharacter+CoreDataProperties.swift
//  MarvelApp
//
//  Created by Kaique Magno Dos Santos on 28/04/18.
//  Copyright © 2018 Kaique Magno. All rights reserved.
//
//

import Foundation
import CoreData


extension FavoriteCharacter {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteCharacter> {
        return NSFetchRequest<FavoriteCharacter>(entityName: "FavoriteCharacter")
    }

    @NSManaged public var characterDescription: String?
    @NSManaged public var id: Int32
    @NSManaged public var isFavorited: Bool
    @NSManaged public var name: String?
    @NSManaged public var thumbnail: FavoriteThumbnail?

}
