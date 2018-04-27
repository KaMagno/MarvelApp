//
//  CharacterDetailRouter.swift
//  XPInvestimento
//
//  Created by Kaique Magno Dos Santos on 21/04/18.
//  Copyright © 2018 Kaique Magno. All rights reserved.
//

import UIKit

class CharacterDetailRouter: NSObject {

    private(set) var presenter:CharacterDetailPresenter!
    
    init(character: Character) {
        //Instancing Variables
        
        super.init()
        
        //
        let storyboard = UIStoryboard(name: "CharacterDetailTableViewController", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "CharacterDetailTableViewController")
        
        //Instancing View
        guard let view = viewController as? CharacterDetailTableViewController else {
            Logger.logError(in: self, message: "Could not cast \(viewController) as CharacterDetailTableViewController")
            return
        }
        
        //Instancing Interactor
        let interactor = CharacterDetailInteractor(character: character)
        //Instancing Presenter
        self.presenter = CharacterDetailPresenter(router: self, interactor: interactor, view: view)
        
    }
    
    func back(animated:Bool) {
        if let navigationController = self.presenter.view.navigationController {
            navigationController.popViewController(animated: true)
        }else{
            self.presenter.view.dismiss(animated: animated, completion: nil)
        }
    }
}
