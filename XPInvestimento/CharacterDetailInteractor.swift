//
//  CharacterDetailInteractor.swift
//  XPInvestimento
//
//  Created by Kaique Magno Dos Santos on 21/04/18.
//  Copyright © 2018 Kaique Magno. All rights reserved.
//

import UIKit

protocol CharacterDetailInteractorDelegate:class {
    func didLoad(comics:[Comic])
    func didLoad(tvshows:[TvShow])
    func didFail(error: Error)
}

class CharacterDetailInteractor: NSObject {

    // MARK: - Properties
    // MARK: Private
    // MARK: Public
    weak var delegate:CharacterDetailInteractorDelegate?
    var character:Character
    var comics:[Comic] = []
    var tvshows:[TvShow] = []
    
    // MARK: - Init
    init(character:Character) {
        self.character = character
    }
    
    // MARK: - Functions
    // MARK: Private
    // MARK: Public
    func fetchComics(){
        
    }
    
    func fetchTvShows(){
        
    }
    
    func setFavorite(value:Bool) {
        DataManager.shared.set(character: self.character, isFavorite: value)
    }
    
    func isFavorite()  -> Bool {
        return DataManager.shared.isFavorited(character: self.chracter)
    }
}
