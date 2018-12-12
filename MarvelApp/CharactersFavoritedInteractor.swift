//
//  CharactersFavoritedInteractor.swift
//  MarvelApp
//
//  Created by Kaique Magno Dos Santos on 26/04/18.
//  Copyright © 2018 Kaique Magno. All rights reserved.
//

import UIKit

protocol CharactersFavoritedInteractorDelegate:class {
    func didLoad()
    func didDelete(at indexPath:IndexPath)
    func didFail(error: Error)
}


class CharactersFavoritedInteractor: NSObject {
    
    // MARK: - Properties
    // MARK: Private
    private var fetchedCharacters  = [FavoriteCharacter]()
    private var searchedCharacters  = [FavoriteCharacter]()
    private var isSearching = false
    // MARK: Public
    var characters:[FavoriteCharacter] {
        if self.isSearching {
            return self.searchedCharacters
        }else{
            return self.fetchedCharacters
        }
    }
    
    weak var delegate:CharactersFavoritedInteractorDelegate?
    
    // MARK: - Init
    override init() {
        super.init()
    }
    
    // MARK: - Functions
    // MARK: Private
    private func loadCharacters(name: String? = nil, nameStartsWith: String? = nil) throws {
    
        let resultCharacters = try DataManager.getFavoriteCharacters(name: name, nameStartsWith: nameStartsWith)
        
        self.isSearching = name != nil || nameStartsWith != nil
        
        if self.isSearching {
            self.searchedCharacters =  resultCharacters
        }else{
            self.fetchedCharacters = resultCharacters
        }
    }

    
    // MARK: Public
    func cleanSearch() {
        self.searchedCharacters = []
    }
    
    
    /// Fetch the Favortie Characters saved on App
    ///
    /// - Parameters:
    ///   - name: <b>optional</b> Filter the Favorite FavoriteCharacter by the name
    ///   - nameStartsWith: <b>optional</b> Filter the Favorite FavoriteCharacter by all characters wich the name starts with
    /// - Throws: CoreData errors
    func fetchCharacters(name: String? = nil, nameStartsWith: String? = nil) throws {
        try self.loadCharacters(name: name, nameStartsWith: nameStartsWith)
        self.delegate?.didLoad()
    }
    
    func removeCharacter(at indexPath:IndexPath) {
        let character = self.characters[indexPath.row]
        
        do {
            try DataManager.unfavorite(character: character)
            try self.loadCharacters()
            self.delegate?.didDelete(at: indexPath)
        } catch  {
            self.delegate?.didFail(error: error)
        }
    }
}

