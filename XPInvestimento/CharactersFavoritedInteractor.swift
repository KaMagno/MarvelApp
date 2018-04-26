//
//  CharactersFavoritedInteractor.swift
//  XPInvestimento
//
//  Created by Kaique Magno Dos Santos on 26/04/18.
//  Copyright © 2018 Kaique Magno. All rights reserved.
//

import UIKit

protocol CharactersFavoritedInteractorDelegate:class {
    func isLoading(_ loading:Bool)
    func didLoad(characters:[Character])
    func didFail(error: Error)
}


class CharactersFavoritedInteractor: NSObject {

    // MARK: - Properties
    // MARK: Private
    private var coreDataManager = CoreDataManager<CharacterFavorited>()
    // MARK: Public
    private(set) var characters = [CharacterFavorited]()
    weak var delegate:CharactersFavoritedInteractorDelegate?
    
    // MARK: - Init
    override init() {
        super.init()
    }
    
    // MARK: - Functions
    // MARK: Private
    // MARK: Public
    func cleanCharacters() {
        self.characters = []
    }
    
    
    /// Fetch the Favortie Characters saved on App
    ///
    /// - Parameters:
    ///   - name: <b>optional</b> Filter the Favorite Character by the name
    ///   - nameStartsWith: <b>optional</b> Filter the Favorite Character by all characters wich the name starts with
    /// - Throws: CoreData errors
    func fetchCharacters(name: String? = nil, nameStartsWith: String? = nil) throws {
        //Filter by Name
        if let nameVerified = name {
            let predicate = NSPredicate(format: "name = %@", nameVerified)
            self.characters = try self.coreDataManager.get(filter: predicate)
        //Filter containing the Name
        } else if let nameStartsWithVerified = nameStartsWith {
            let predicate = NSPredicate(format: "name contains %@", nameStartsWithVerified)
            self.characters = try self.coreDataManager.get(filter: predicate)
        //No Filter
        } else {
            self.characters = try self.coreDataManager.get()
        }
    }
    
    func remove(characterFavorited:CharacterFavorited) {
        self.coreDataManager.delete(object: characterFavorited)
    }
}

