//
//  DataManager.swift
//  XPInvestimento
//
//  Created by Kaique Magno Dos Santos on 21/04/18.
//  Copyright © 2018 Kaique Magno. All rights reserved.
//

import UIKit

/// DataManager group all function related to data. This class is a layer to handle CoreData and API data management.
class DataManager {
    
    // MARK: - Properties
    // MARK: Private
    private let session = URLSession(configuration: .default)
    
    // MARK: Public
    static let shared:DataManager = DataManager()
    
    // MARK: - Init
    private init(){
        
    }
    
    // MARK: - Functions
    // MARK: -- Private
    // MARK: -- Public
    
    // MARK: Characters
    func getCharacters(name: String? = nil, nameStartsWith: String? = nil, limit: Int? = nil, offset: Int? = nil, completion:@escaping ResultCallback<[Character]>) {
        
        //Get characters from API
        let request = GetCharacters(name: name, nameStartsWith: nameStartsWith, limit: limit, offset: offset)
        APIManager.shared.send(request, completion: { (response) in
            
            //Response from API
            switch response {
            case .success(let dataContainer):
                //Verify if any Character is saved
                let characters = dataContainer.results.map({ (characterElement) -> Character in
                    let coreDataManager = CoreDataManager<Character>()

                    let predicate = NSPredicate(format: "id = %i", characterElement.id)
                    characterElement.isFavorited = coreDataManager.exist(predicate: predicate)

                    return characterElement
                })
                //
                completion(.success(characters))
                
            case .failure(let error):
                //
                completion(.failure(error))
            }
        })
    }
    
    func getFavoriteCharacters() throws -> [Character] {
        let coreDataManager = CoreDataManager<Character>()
        let characters = try coreDataManager.get(filter: nil)
        return characters
    }
    
    
    func set(character:Character, isFavorite:Bool) {
        //
        let characterCoreDataManager = CoreDataManager<Character>()
        if isFavorite {
            if let thumbnail = character.thumbnail{
                let thumbnailCoreDataManager = CoreDataManager<Thumbnail>()
                thumbnailCoreDataManager.insert(object: thumbnail)
            }
            characterCoreDataManager.insert(object: character)
        }else{
            characterCoreDataManager.delete(object: character)
        }
        CoreDataSingleton.shared.saveContext()
    }
    
    func isFavorited(character:Character) -> Bool {
        let coreDataManager = CoreDataManager<Character>()
        let predicate = NSPredicate(format: "id = %i", character.id)
        return coreDataManager.exist(predicate: predicate)
    }
    
    // MARK: Comics
    func getComics(character:Character, completion:@escaping ResultCallback<[Comic]>) {
        
        //Get characters from API
        let request = GetCharacterComics(characterId: Int(character.id))
        APIManager.shared.send(request, completion: { (response) in
            
            //Response from API
            switch response {
            case .success(let dataContainer):
                //Verify if any Character is saved
                completion(.success(dataContainer.results))
                
            case .failure(let error):
                //
                completion(.failure(error))
            }
        })
    }
    
    // MARK: Series
    func getSeries(character:Character, completion:@escaping ResultCallback<[Serie]>) {
        //Get characters from API
        let request = GetCharacterSeries(characterId: Int(character.id))
        APIManager.shared.send(request, completion: { (response) in
            
            //Response from API
            switch response {
            case .success(let dataContainer):
                //Verify if any Character is saved
                completion(.success(dataContainer.results))
                
            case .failure(let error):
                //
                completion(.failure(error))
            }
        })
    }
}
