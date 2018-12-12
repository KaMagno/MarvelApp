//
//  FavoriteCharacter+CoreDataClass.swift
//  MarvelApp
//
//  Created by Kaique Magno Dos Santos on 28/04/18.
//  Copyright © 2018 Kaique Magno. All rights reserved.
//
//

import Foundation
import CoreData

@objc(FavoriteCharacter)
public class FavoriteCharacter: NSManagedObject {
    // MARK: Decodable
    convenience required init(character: Character, in context:NSManagedObjectContext) throws  {
        
        guard let entity = NSEntityDescription.entity(forEntityName: "FavoriteCharacter", in: context) else {
            Logger.logError(in: FavoriteCharacter.self, message: "Failed to instance NSEntityDescription")
            throw Erros.couldNotInstance
        }
        
        var favoriteThumbnail:FavoriteThumbnail?
        
        if let favoriteCharacterThumbnail = character.thumbnail {
            favoriteThumbnail = try FavoriteThumbnail(thumbnail: favoriteCharacterThumbnail, in: context)
            context.insert(favoriteThumbnail!)
        }else{
            favoriteThumbnail = nil
        }
        
        self.init(entity: entity, insertInto: context)
        
        self.id = Int32(character.id)
        self.name = character.name
        self.characterDescription = character.description
        
        context.insert(self)
        self.thumbnail = favoriteThumbnail
    }
}
