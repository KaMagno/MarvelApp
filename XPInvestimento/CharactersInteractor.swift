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
    var characters:[Character] {
        if self.isSearching {
            return self.searchedCharacters
        }else{
            return self.fetchedCharacters
        }
    }
    
    private(set) var isSearching = false
    weak var delegate:CharactersInteractorDelegate?
    
    // MARK: - Init
    override init() {
        super.init()
        DataManager.shared.delegate = self
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
        DataManager.shared.getCharacters(name: name, nameStartsWith: nameStartsWith, limit: limit, offset: self.offset)
    }
    
    func setFavorite(value:Bool,for character:Character) {
        DataManager.shared.set(character: character, isFavorite: value)
    }
    
    func isFavorite(chracter:Character)  -> Bool {
        return DataManager.shared.isFavorited(character: chracter)
    }
}

extension CharactersInteractor:DataManagerDelegate {
    func didLoad(comics: [Comic]) {
        //
    }
    
    func didLoad(series: [Serie]) {
        //
    }
    
    func didLoad(characters: [Character]) {
        if self.isSearching {
            self.searchedCharacters.append(contentsOf: characters)
            self.delegate?.didLoad()
        }else{
            self.fetchedCharacters.append(contentsOf: characters)
            self.delegate?.didLoad()
        }
    }
    func didFail(error: Error) {
        self.delegate?.didFail(error: error)
    }
}
