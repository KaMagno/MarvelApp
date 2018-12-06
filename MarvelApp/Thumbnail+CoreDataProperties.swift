//
//  Thumbnail+CoreDataProperties.swift
//  XPInvestimento
//
//  Created by Kaique Magno Dos Santos on 28/04/18.
//  Copyright © 2018 Kaique Magno. All rights reserved.
//
//

import Foundation
import CoreData


extension Thumbnail {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Thumbnail> {
        return NSFetchRequest<Thumbnail>(entityName: "Thumbnail")
    }

    @NSManaged public var data: NSData?
    @NSManaged public var url: String?

}
