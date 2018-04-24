//
//  CharacterImage+CoreDataProperties.swift
//  XPInvestimento
//
//  Created by Kaique Magno Dos Santos on 23/04/18.
//  Copyright © 2018 Kaique Magno. All rights reserved.
//
//

import Foundation
import CoreData

extension CharacterImage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CharacterImage> {
        return NSFetchRequest<CharacterImage>(entityName: "CharacterImage")
    }

    @NSManaged public var url: URL?
    @NSManaged public var imageData: NSData?

}
