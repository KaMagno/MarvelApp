//
//  DataManager.swift
//  XPInvestimento
//
//  Created by Kaique Magno Dos Santos on 21/04/18.
//  Copyright © 2018 Kaique Magno. All rights reserved.
//

import UIKit

protocol DataManagerDelegate:class {
    func didLoad(characters: [Character])
    func didFail(error: Error)
}

class DataManager {
    
    // MARK: - Properties
    // MARK: Private
    private let session = URLSession(configuration: .default)
    
    // MARK: Public
    static let shared:DataManager = DataManager()
    weak var delegate:DataManagerDelegate?
    
    // MARK: - Init
    private init(){
        
    }
    
    // MARK: - Functions
    // MARK: Private
    // MARK: Public
    func getCharacters(name: String? = nil, nameStartsWith: String? = nil, limit: Int? = nil, offset: Int? = nil) {
        guard let delegateVerified = self.delegate else {
            Logger.logError(in: self, message: "Delegate is nil")
            return
        }
        
        
        
        //Get characters from API
        let request = GetCharacters(name: name, nameStartsWith: nameStartsWith, limit: limit, offset: offset)
        APIManager.shared.send(request, completion: { (response) in
            
            //Response from API
            switch response {
            case .success(let dataContainer):
                //Verify if any Character is saved
                let characters = dataContainer.results.map({ (characterElement) -> Character in
                    let coreDataManager = CoreDataManager<CharacterFavorited>()
                    
                    var character = characterElement
                    let predicate = NSPredicate(format: "id = %i", character.id)
                    character.isFavorited = coreDataManager.exist(predicate: predicate)

                    return character
                })
                //
                delegateVerified.didLoad(characters: characters)
                
            case .failure(let error):
                //
                delegateVerified.didFail(error: error)
            }
        })
    }
    
    func getFavoriteCharacters() {
        guard let delegateVerified = self.delegate else {
            Logger.logError(in: self, message: "Delegate is nil")
            return
        }
        
        do {
            let coreDataManager = CoreDataManager<CharacterFavorited>()
            let charactersFavorited = try coreDataManager.get(filter: nil)
            let characters = charactersFavorited.map { (characterFavorited) -> Character in
                return Character(characterFavorited: characterFavorited)
            }
            delegateVerified.didLoad(characters: characters)
        } catch {
            Logger.logError(in: self, message: error.localizedDescription)
            delegateVerified.didFail(error: error)
        }
    }
    
    
    func set(character:Character, isFavorite:Bool) {
        //
    }
    
    
    
}
