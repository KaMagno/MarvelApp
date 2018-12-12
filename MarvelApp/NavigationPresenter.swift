//
//  NavigationPresenter.swift
//  MarvelApp
//
//  Created by Kaique Magno Dos Santos on 24/04/18.
//  Copyright © 2018 Kaique Magno. All rights reserved.
//

import UIKit

class NavigationPresenter: NSObject {

    
    // MARK: - Variables
    // MARK: Private
    // MARK: Public
    var router:NavigationRouter
    var interactor:NavigationInteractor
    var view:NavigationViewController
    
    // MARK: - Initializers
    init(router:NavigationRouter,interactor:NavigationInteractor,view:NavigationViewController) {
        self.router = router
        self.interactor = interactor
        self.view = view
        
        super.init()
        self.view.presenter = self
    }
    
    // MARK: - Functions
    // MARK: Private
    // MARK: Public

    
}
