//
//  CharactersRouter.swift
//  XPInvestimento
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
}
