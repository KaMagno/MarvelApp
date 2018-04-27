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
    func didLoad(characters:[Character])
    func didFail(error: Error)
}

class CharactersInteractor: NSObject {

    // MARK: - Properties
    // MARK: Private
    private var offset:Int = 0
    // MARK: Public
    private(set) var characters = [Character]()
    weak var delegate:CharactersInteractorDelegate?
    
    // MARK: - Init
    override init() {
        super.init()
        DataManager.shared.delegate = self
    }
    
    // MARK: - Functions
    // MARK: Private
    // MARK: Public
    func cleanCharacters() {
        self.characters = [Character]()
    }
    
    func fetchCharacters(name: String? = nil, nameStartsWith: String? = nil, limit: Int? = nil, offset: Int? = nil) {
        if let offsetVerified = offset {
            self.offset = offsetVerified > self.offset ? self.offset+Constants.MarvelAPI.offset : self.offset
        }
        if nameStartsWith != nil {
            self.offset = 0
            self.cleanCharacters()
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
        self.characters.append(contentsOf: characters)
        self.delegate?.didLoad(characters: characters)
    }
    func didFail(error: Error) {
        self.delegate?.didFail(error: error)
    }
}
