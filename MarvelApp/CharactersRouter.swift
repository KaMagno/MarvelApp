//
//  CharactersRouter.swift
//  MarvelApp
//
//  Created by Kaique Magno Dos Santos on 21/04/18.
//  Copyright © 2018 Kaique Magno. All rights reserved.
//

import UIKit

class CharactersRouter:NSObject {
   
    var presenter: CharactersPresenter!
    
    override init() {
        //Instancing Variables
        super.init()
        
        let storyboard = UIStoryboard(name: "CharactersCollectionViewController", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "CharactersCollectionViewController")
        
        //Instancing View
        guard let view = viewController as? CharactersCollectionViewController else {
            Logger.logError(in: CharactersRouter.self, message: "Could not cast \(viewController) as CharactersCollectionViewController")
            return
        }
        
        //Instancing Interactor
        let interactor = CharactersInteractor()
        //Instancing Presenter
        self.presenter = CharactersPresenter(router: self, interactor: interactor, view: view)
    }
    
    deinit {
        ImageManager.shared.cleanCache()
    }
    
    func showDetailt(of character:Character) {
        CharacterDetailRouter.show(character: character, from: self.presenter.view)
    }
    
    func showDetailt(of character:FavoriteCharacter) {
        let character = Character(favoriteCharacter: character)
        self.showDetailt(of: character)
    }
    
    func showAlert(message:String) {
        AlertRouter.showAlert(with: message, sender: self.presenter.view)
    }
}
