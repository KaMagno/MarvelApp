//
//  FavoriteThumbnail+CoreDataClass.swift
//  MarvelApp
//
//  Created by Kaique Magno Dos Santos on 28/04/18.
//  Copyright © 2018 Kaique Magno. All rights reserved.
//
//

import UIKit
import CoreData

@objc(FavoriteThumbnail)
public class FavoriteThumbnail: NSManagedObject {
    //
    required convenience init(thumbnail: Thumbnail, in context:NSManagedObjectContext) throws {
        //
        guard let entity = NSEntityDescription.entity(forEntityName: "FavoriteThumbnail", in: context) else {
            Logger.logError(in: FavoriteThumbnail.self, message: "Failed to instance NSEntityDescription")
            throw Erros.couldNotInstance
        }
        
        self.init(entity: entity, insertInto: context)
        
        //URL
        self.url = thumbnail.url?.absoluteString
        
        //Data
        self.data = UIImagePNGRepresentation(thumbnail.image)! as NSData
    }
}
