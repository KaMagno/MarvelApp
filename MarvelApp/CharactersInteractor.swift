//
//  CharactersInteractor.swift
//  MarvelApp
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

    enum Status {
        case normal
        case searching(name: String?, nameStartsWith: String?)
    }
    
    // MARK: - Properties
    // MARK: Private
    private var fetchedCharacters = [Character]()
    private var searchedCharacters = [Character]()
    private var popularMoviesPage:Int = 0
    private var searchMoviesPage:Int = 0
    
    
    // MARK: Public
    private(set) var offsetLastModified:Int = 0
    var offset:Int {
        switch self.status {
        case .normal:
            return self.popularMoviesPage
        case .searching:
            return self.searchMoviesPage
        }
    }
    
    private(set) var characters:[Character] {
        get {
            switch self.status {
            case .normal:
                return self.fetchedCharacters
            case .searching(name: _, nameStartsWith: _):
                return self.searchedCharacters
            }
        }
        set{
            switch self.status {
            case .normal:
                self.fetchedCharacters = newValue
            case .searching(name: _, nameStartsWith: _):
                self.searchedCharacters = newValue
            }
        }
    }
    
    private(set) var status:Status = .normal
    
    weak var delegate:CharactersInteractorDelegate?
    
    // MARK: - Init
    override init() {
        super.init()
    }
    
    // MARK: - Functions
    // MARK: Private
    // MARK: Public
    func change(status:Status) {
        self.status = status
    }
    
    func cancelSearchCharatcers() {
        self.status = .normal
        self.searchedCharacters = [Character]()
        self.searchMoviesPage = 0
        self.delegate?.didLoad()
    }
    
    func fetchCharacters(limit: Int? = nil, offset: Int? = nil) {
        switch self.status {
        case .normal:
            self.offsetLastModified = self.offset
            if let offset = offset {
                if offset >= self.offset {
                    self.popularMoviesPage = offset
                } else {
                    self.popularMoviesPage = self.offset <= 1 ? 1: self.popularMoviesPage - 1
                }
            }
            
            DataManager.getCharacters(limit: limit, offset: self.offset) { (result) in
                switch result {
                case .success(let charactersResult):
                    self.characters.append(contentsOf: charactersResult)
                    self.delegate?.didLoad()
                case .failure(let error):
                    self.delegate?.didFail(error: error)
                }
            }
            
        case .searching(name: let characterName, nameStartsWith: let characterNameStart):
            self.offsetLastModified = self.offset
            if let offset = offset {
                if offset >= self.offset {
                    self.searchMoviesPage = offset
                } else {
                    self.searchMoviesPage = self.offset <= 1 ? 1: self.searchMoviesPage - 1
                }
            }
            
            DataManager.getCharacters(name: characterName, nameStartsWith: characterNameStart, limit: limit, offset: self.offset) { (result) in
                switch result {
                case .success(let charactersResult):
                    self.characters.append(contentsOf: charactersResult)
                    self.delegate?.didLoad()
                case .failure(let error):
                    self.delegate?.didFail(error: error)
                }
            }
        }
    }
    
    
    func update(image:UIImage, at indexPath:IndexPath) {
        switch self.status {
        case .normal:
            self.fetchedCharacters[indexPath.row].thumbnail?.image = image
        case .searching(name: _, nameStartsWith: _):
            self.searchedCharacters[indexPath.row].thumbnail?.image = image
        }
    }
    
    
    func setFavorite(value:Bool,for character:Character) {
        do{
            if value {
                try DataManager.favorite(character: character)
            }else{
                try DataManager.unfavorite(character: character)
            }
        }catch{
            self.delegate?.didFail(error: error)
        }
        
    }
    
    func isFavorite(chracter:Character)  -> Bool {
        return DataManager.isFavorited(character: chracter)
    }
}
