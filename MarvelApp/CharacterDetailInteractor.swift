//
//  CharacterDetailInteractor.swift
//  MarvelApp
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
    }
    
    // MARK: - Functions
    // MARK: Private
    // MARK: Public
    func fetchComics(){
        DataManager.getComics(character: self.character) { (result) in
            switch result {
            case .success(let comicsResult):
                self.comics = comicsResult
                self.delegate?.didLoad(comics: comicsResult)
            case .failure(let error):
                self.delegate?.didFail(error: error)
            }
        }
    }
    
    func fetchSeries(){
        DataManager.getSeries(character: self.character) { (result) in
            switch result {
            case .success(let seriesResult):
                self.series = seriesResult
                self.delegate?.didLoad(series: seriesResult)
            case .failure(let error):
                self.delegate?.didFail(error: error)
            }
        }
    }
    
    func setFavorite(value:Bool) {
        do {
            try DataManager.favorite(character: self.character)
        } catch {
            self.delegate?.didFail(error: error)
        }
    }
    
    func isFavorite()  -> Bool {
        return DataManager.isFavorited(character: self.character)
    }
}
