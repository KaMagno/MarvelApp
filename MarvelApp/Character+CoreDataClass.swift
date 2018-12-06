//
//  Character+CoreDataClass.swift
//  XPInvestimento
//
//  Created by Kaique Magno Dos Santos on 28/04/18.
//  Copyright © 2018 Kaique Magno. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Character)
public class Character: NSManagedObject,Decodable {
    //
    private enum Keys:String,CodingKey {
        case id
        case name
        case description
        case thumbnail
    }
    
    // MARK: Decodable
    public convenience required init(from decoder: Decoder) throws {
        
        // Create NSEntityDescription with NSManagedObjectContext
        //        guard let contextUserInfoKey = CodingUserInfoKey.context else {
        //            Logger.logError(in: Character.self, message: "Failed to get CodingUserInfoKey")
        //            throw Erros.couldNotInstance
        //        }
        guard let managedObjectContext = decoder.userInfo[.context] as? NSManagedObjectContext else {
            Logger.logError(in: Character.self, message: "Failed to cast to NSManagedObjectContext")
            throw Erros.couldNotInstance
        }
        guard let entity = NSEntityDescription.entity(forEntityName: "Character", in: managedObjectContext) else {
            Logger.logError(in: Character.self, message: "Failed to instance NSEntityDescription")
            throw Erros.couldNotInstance
        }
        
        self.init(entity: entity, insertInto: nil)
        
        let container = try decoder.container(keyedBy: Keys.self)
        self.id = try container.decode(Int32.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        let descriptionTemp = try container.decodeIfPresent(String.self, forKey: .description)
        if let descriptionVerified = descriptionTemp {
            self.characterDescription = descriptionVerified
        }else{
            self.characterDescription = ""
        }
        self.thumbnail = try container.decode(Thumbnail.self, forKey: .thumbnail)
        self.isFavorited = false
        
    }
}
