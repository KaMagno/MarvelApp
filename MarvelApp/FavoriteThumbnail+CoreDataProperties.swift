//
//  FavoriteThumbnail+CoreDataProperties.swift
//  MarvelApp
//
//  Created by Kaique Magno Dos Santos on 28/04/18.
//  Copyright © 2018 Kaique Magno. All rights reserved.
//
//

import Foundation
import CoreData


extension FavoriteThumbnail {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteThumbnail> {
        return NSFetchRequest<FavoriteThumbnail>(entityName: "FavoriteThumbnail")
    }

    @NSManaged public var data: NSData?
    @NSManaged public var url: String?

}
