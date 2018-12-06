//
//  Thumbnail+CoreDataClass.swift
//  XPInvestimento
//
//  Created by Kaique Magno Dos Santos on 28/04/18.
//  Copyright © 2018 Kaique Magno. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Thumbnail)
public class Thumbnail: NSManagedObject,Decodable {

    //
    private enum Keys: String, CodingKey {
        case path = "path"
        case fileExtension = "extension"
    }
    
    //
    public required convenience init(from decoder: Decoder) throws {
        //
        guard let managedObjectContext = decoder.userInfo[.context] as? NSManagedObjectContext else {
            Logger.logError(in: Thumbnail.self, message: "Failed to cast to NSManagedObjectContext")
            throw Erros.couldNotInstance
        }
        guard let entity = NSEntityDescription.entity(forEntityName: "Thumbnail", in: managedObjectContext) else {
            Logger.logError(in: Thumbnail.self, message: "Failed to instance NSEntityDescription")
            throw Erros.couldNotInstance
        }
        
        self.init(entity: entity, insertInto: nil)
        
        let container = try decoder.container(keyedBy: Keys.self)
        
        //URL
        let path = try container.decode(String.self, forKey: .path)
        let fileExtension = try container.decode(String.self, forKey: .fileExtension)
        self.url = "\(path).\(fileExtension)"
        
        //Data
        self.data = nil
    }
}
