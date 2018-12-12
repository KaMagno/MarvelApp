//
//  DataManager.swift
//  MarvelApp
//
//  Created by Kaique Magno Dos Santos on 21/04/18.
//  Copyright © 2018 Kaique Magno. All rights reserved.
//

import UIKit

/// DataManager group all function related to data. This class is a layer to handle CoreData and API data management.
final class DataManager {
    
    // MARK: - Properties
    // MARK: Private
    // MARK: - Init
    private init(){
        
    }
    
    // MARK: - Functions
    // MARK: -- Private
    // MARK: -- Public
    
    // MARK: Characters
    static func getCharacters(name: String? = nil, nameStartsWith: String? = nil, limit: Int? = nil, offset: Int? = nil, completion:@escaping (Result<[Character]>) -> Void) {
        
        //Get characters from API
        let request = GetCharacters(name: name, nameStartsWith: nameStartsWith, limit: limit, offset: offset)
        APIManager.shared.send(request, completion: { (response) in
            
            //Response from API
            switch response {
            case .success(let dataContainer):
                //Verify if any FavoriteCharacter is saved
                completion(.success(dataContainer.results))
                
            case .failure(let error):
                //
                completion(.failure(error))
            }
        })
    }
    
    static func getFavoriteCharacters(name: String? = nil, nameStartsWith: String? = nil) throws -> [FavoriteCharacter] {
        let coreDataManager = CoreDataManager<FavoriteCharacter>()
        var characters = [FavoriteCharacter]()
        
        if let nameVerified = name {
            let predicate = NSPredicate(format: "name = %@", nameVerified)
            characters = try coreDataManager.get(filter: predicate)
            //Filter containing the Name
        } else if let nameStartsWithVerified = nameStartsWith {
            let predicate = NSPredicate(format: "name contains %@", nameStartsWithVerified)
            characters = try coreDataManager.get(filter: predicate)
            //No Filter
        } else {
            characters = try coreDataManager.get()
        }
        
        return characters
    }
    
    
    static func favorite(character:Character) throws {
        //
        let characterCoreDataManager = CoreDataManager<FavoriteCharacter>()
        if let thumbnail = character.thumbnail{
            let thumbnailCoreDataManager = CoreDataManager<FavoriteThumbnail>()
            let favoriteThumbnail = try FavoriteThumbnail(thumbnail: thumbnail, in: CoreDataSingleton.shared.persistentContainer.viewContext)
            thumbnailCoreDataManager.insert(object: favoriteThumbnail)
        }
        
        let favoritedCharacter = try FavoriteCharacter(character: character, in: CoreDataSingleton.shared.persistentContainer.viewContext)
        characterCoreDataManager.insert(object: favoritedCharacter)
        
        CoreDataSingleton.shared.saveContext()
    }
    
    static func unfavorite(character:Character) throws {
        //
        let characterCoreDataManager = CoreDataManager<FavoriteCharacter>()
        let predicate = NSPredicate(format: "id = %i", Int32(character.id))
        let favoriteCharacters = try characterCoreDataManager.get(filter: predicate)
        if let favoriteCharacter = favoriteCharacters.first {
            characterCoreDataManager.delete(object: favoriteCharacter)
        }else{
            throw NSError(domain: "CoreData", code: 404, userInfo: ["localizedDescription":"Could not find the character"])
        }
        
        CoreDataSingleton.shared.saveContext()
    }
    
    static func unfavorite(character:FavoriteCharacter) throws {
        //
        let character = Character.init(favoriteCharacter: character)
        try DataManager.unfavorite(character: character)
    }
    
    static func isFavorited(character:Character) -> Bool {
        let coreDataManager = CoreDataManager<FavoriteCharacter>()
        let predicate = NSPredicate(format: "id = %i", character.id)
        return coreDataManager.exist(predicate: predicate)
    }
    
    // MARK: Comics
    static func getComics(character:Character, completion:@escaping ResultCallback<[Comic]>) {
        
        //Get characters from API
        let request = GetCharacterComics(characterId: Int(character.id))
        APIManager.shared.send(request, completion: { (response) in
            
            //Response from API
            switch response {
            case .success(let dataContainer):
                //Verify if any FavoriteCharacter is saved
                completion(.success(dataContainer.results))
                
            case .failure(let error):
                //
                completion(.failure(error))
            }
        })
    }
    
    // MARK: Series
    static func getSeries(character:Character, completion:@escaping ResultCallback<[Serie]>) {
        //Get characters from API
        let request = GetCharacterSeries(characterId: Int(character.id))
        APIManager.shared.send(request, completion: { (response) in
            
            //Response from API
            switch response {
            case .success(let dataContainer):
                //Verify if any FavoriteCharacter is saved
                completion(.success(dataContainer.results))
                
            case .failure(let error):
                //
                completion(.failure(error))
            }
        })
    }
}
