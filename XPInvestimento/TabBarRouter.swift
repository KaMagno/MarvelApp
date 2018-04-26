//
//  TabBarRouter.swift
//  XPInvestimento
//
//  Created by Kaique Magno Dos Santos on 26/04/18.
//  Copyright © 2018 Kaique Magno. All rights reserved.
//

import UIKit

class TabBarRouter: NSObject {
    
    private(set) var presenter:TabBarPresenter!
    
    private override init() {}
    
    required init(viewControllers:[UIViewController]) {
        //Instancing Variables
        
        super.init()
        
        //
        let storyboard = UIStoryboard(name: "TabBarViewController", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "TabBarViewController")
        
        //Instancing View
        guard let view = viewController as? TabBarViewController else {
            Logger.logError(in: self, message: "Could not cast \(viewController) as TabBarViewController")
            return
        }
        
        view.viewControllers = viewControllers
        
        //Instancing Interactor
        let interactor = TabBarInteractor()
        //Instancing Presenter
        self.presenter = TabBarPresenter(router: self, interactor: interactor, view: view)
    }
}
