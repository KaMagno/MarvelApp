//
//  CharactersInteractor.swift
//  XPInvestimento
//
//  Created by Kaique Magno Dos Santos on 21/04/18.
//  Copyright © 2018 Kaique Magno. All rights reserved.
//

import UIKit

protocol CharactersInteractorDelegate:class {
    func didLoad(characters:[Character])
    func didFail(error: Error)
}

class CharactersInteractor: NSObject {

    // MARK: - Properties
    // MARK: Private
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
    func fetchCharacters() {
        DataManager.shared.getCharacters()
    }
    
    func isFavorited(_ character:Character) -> Bool {
        
        return false
    }
    
    func setFavoriteStatus(for character:Character) {
        //TODO: Save in CoreData. Might create a CoreData Manager and change the Name of the DataManager to APIManager
    }
}

extension CharactersInteractor:DataManagerDelegate {
    func didLoad(characters: [Character]) {
        self.characters = characters
        self.delegate?.didLoad(characters: characters)
    }
    func didFail(error: Error) {
        self.delegate?.didFail(error: error)
    }
}
