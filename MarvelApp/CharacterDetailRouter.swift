//
//  CharacterDetailRouter.swift
//  XPInvestimento
//
//  Created by Kaique Magno Dos Santos on 21/04/18.
//  Copyright © 2018 Kaique Magno. All rights reserved.
//

import UIKit

class CharacterDetailRouter {

    private(set) var presenter:CharacterDetailPresenter!
    
    init(character: Character) {
        
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
    
    func showAlertLoadindDataError() {
        AlertRouter.showAlert(with: "We had a problem. Probably is Thanos messing around.", sender: self.presenter.view)
    }
    
    func showAlert(message:String) {
        AlertRouter.showAlert(with: message, sender: self.presenter.view)
    }
    
    
    static func show(character:Character, from sender:UIViewController) {
        let router = CharacterDetailRouter(character: character)
        if let navigationController = sender.navigationController {
            navigationController.pushViewController(router.presenter.view, animated: true)
        }else{
            sender.present(router.presenter.view, animated: true, completion: nil)
        }
    }
}
