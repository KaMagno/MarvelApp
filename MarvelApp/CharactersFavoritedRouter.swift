//
//  CharactersFavorited.swift
//  MarvelApp
//
//  Created by Kaique Magno Dos Santos on 26/04/18.
//  Copyright © 2018 Kaique Magno. All rights reserved.
//

import UIKit

class CharactersFavoritedRouter: NSObject {

    private(set) var presenter:CharactersFavoritedPresenter!
    
    override init() {
        //Instancing Variables
        
        super.init()
        
        //
        let storyboard = UIStoryboard(name: "CharactersFavoritedCollectionViewController", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "CharactersFavoritedCollectionViewController")
        
        //Instancing View
        guard let view = viewController as? CharactersFavoritedCollectionViewController else {
            Logger.logError(in: self, message: "Could not cast \(viewController) as CharactersFavoritedCollectionViewController")
            return
        }
        
        //Instancing Interactor
        let interactor = CharactersFavoritedInteractor()
        //Instancing Presenter
        self.presenter = CharactersFavoritedPresenter(router: self, interactor: interactor, view: view)
    }
    
    func showDetailt(of character:Character) {
        CharacterDetailRouter.show(character: character, from: self.presenter.view)
    }
    
    func showDetailt(of character:FavoriteCharacter) {
        let character = Character(favoriteCharacter: character)
        self.showDetailt(of: character)
    }
    
    func showAlert(message:String, buttonTitle:String = "Okay") {
        AlertRouter.showAlert(with: message, buttonTitle: buttonTitle, sender: self.presenter.view)
    }
    
    func showAlertLoadindDataError() {
        AlertRouter.showAlert(with: "It was not possible to load the Favorited Characters", sender: self.presenter.view)
    }
}
