//
//  CharactersInteractor.swift
//  XPInvestimento
//
//  Created by Kaique Magno Dos Santos on 21/04/18.
//  Copyright © 2018 Kaique Magno. All rights reserved.
//

import UIKit

protocol CharactersInteractorDelegate:class {
    func isLoading(_ loading:Bool)
    func didLoad()
    func didFail(error: Error)
}

class CharactersInteractor: NSObject {

    // MARK: - Properties
    // MARK: Private
    private var fetchedCharacters = [Character]()
    private var searchedCharacters = [Character]()
    
    // MARK: Public
    private(set) var offsetLastModified:Int = 0
    private(set) var offset:Int = 0
    private(set) var characters:[Character] {
        get {
            if self.isSearching {
                return self.searchedCharacters
            }else{
                return self.fetchedCharacters
            }
        }
        
        set{
            if self.isSearching {
                return self.searchedCharacters = newValue
            }else{
                return self.fetchedCharacters = newValue
            }
        }
        
    }
    
    private(set) var isSearching = false
    weak var delegate:CharactersInteractorDelegate?
    
    // MARK: - Init
    override init() {
        super.init()
    }
    
    // MARK: - Functions
    // MARK: Private
    // MARK: Public
    func cancelSearchCharatcers() {
        self.isSearching = false
        self.searchedCharacters = [Character]()
        self.offset = 0
        self.delegate?.didLoad()
    }
    
    func fetchCharacters(name: String? = nil, nameStartsWith: String? = nil, limit: Int? = nil, offset: Int? = nil) {
        
        if nameStartsWith != nil {
            self.isSearching = true
            self.searchedCharacters = [Character]()
        }
        
        self.offsetLastModified = self.offset
        if let offsetVerified = offset {
            if offsetVerified >= self.offset {
                self.offset = self.offset+Constants.MarvelAPI.offset
            } else {
                self.offset = self.offset <= 0 ? 0: self.offset-Constants.MarvelAPI.offset
            }
        }
        DataManager.getCharacters(name: name, nameStartsWith: nameStartsWith, limit: limit, offset: self.offset) { (result) in
            switch result {
            case .success(let charactersResult):
                self.characters.append(contentsOf: charactersResult)
                self.delegate?.didLoad()
            case .failure(let error):
                self.delegate?.didFail(error: error)
        }
        }
    }
    
    func setFavorite(value:Bool,for character:Character) {
        DataManager.set(character: character, isFavorite: value)
    }
    
    func isFavorite(chracter:Character)  -> Bool {
        return DataManager.isFavorited(character: chracter)
    }
}
