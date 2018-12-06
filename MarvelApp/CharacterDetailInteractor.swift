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
    func didLoad(series:[Serie])
    func didFail(error: Error)
}

class CharacterDetailInteractor {

    // MARK: - Properties
    // MARK: Private
    // MARK: Public
    weak var delegate:CharacterDetailInteractorDelegate?
    var character:Character
    var comics:[Comic] = []
    var series:[Serie] = []
    
    // MARK: - Init
    init(character:Character) {
        self.character = character
        DataManager.shared.delegate = self
    }
    
    // MARK: - Functions
    // MARK: Private
    // MARK: Public
    func fetchComics(){
        DataManager.shared.getComics(character: self.character)
    }
    
    func fetchSeries(){
        DataManager.shared.getSeries(character: self.character)
    }
    
    func setFavorite(value:Bool) {
        DataManager.shared.set(character: self.character, isFavorite: value)
    }
    
    func isFavorite()  -> Bool {
        return DataManager.shared.isFavorited(character: self.character)
    }
}

extension CharacterDetailInteractor:DataManagerDelegate {
    func didLoad(comics: [Comic]) {
        self.comics = comics
        self.delegate?.didLoad(comics: comics)
    }
    
    func didLoad(series: [Serie]) {
        self.series = series
        self.delegate?.didLoad(series: series)
    }
    
    func didLoad(characters: [Character]) {
        //
    }
    
    func didFail(error: Error) {
        self.delegate?.didFail(error: error)
    }
    
    
}
