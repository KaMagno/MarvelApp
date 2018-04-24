//
//  CharacterImage+CoreDataClass.swift
//  XPInvestimento
//
//  Created by Kaique Magno Dos Santos on 23/04/18.
//  Copyright © 2018 Kaique Magno. All rights reserved.
//
//

import UIKit
import CoreData

@objc(CharacterImage)
public class CharacterImage: NSManagedObject {

    
    required convenience public init?(character:Character, in context:NSManagedObjectContext) {
        guard let thumbnail = character.thumbnail else {
            Logger.log(in: CharacterImage.self, message: "Character.thumbnail is nil")
            return nil
        }
        guard let image = character.image else {
            Logger.log(in: CharacterImage.self, message: "Character.Image is nil")
            return nil
        }
        guard let imagePNGData = UIImagePNGRepresentation(image) else {
            Logger.log(in: CharacterImage.self, message: "Coulod not compress UIImage into PNG format")
            return nil
        }
        
        self.init(entity: CharacterImage.entity(), insertInto: context)
        
        self.url = thumbnail.url
        
        
        self.imageData = imagePNGData as NSData
    }
    
}
