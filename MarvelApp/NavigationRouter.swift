//
//  NavigationRouter.swift
//  MarvelApp
//
//  Created by Kaique Magno Dos Santos on 24/04/18.
//  Copyright © 2018 Kaique Magno. All rights reserved.
//

import UIKit

class NavigationRouter: NSObject {

    private(set) var presenter:NavigationPresenter!
    
    init(rootViewController:UIViewController) {
        //Instancing Variables
        
        super.init()
        
        //
        let navigation = NavigationViewController(rootViewController: rootViewController)
        
        //Instancing Interactor
        let interactor = NavigationInteractor()
        
        //Instancing Presenter
        self.presenter = NavigationPresenter(router: self, interactor: interactor, view: navigation)
        
    }
}
