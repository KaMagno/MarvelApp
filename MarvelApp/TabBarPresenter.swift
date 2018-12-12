//
//  TabBarPresenter.swift
//  MarvelApp
//
//  Created by Kaique Magno Dos Santos on 26/04/18.
//  Copyright © 2018 Kaique Magno. All rights reserved.
//

import UIKit

class TabBarPresenter: NSObject {

    // MARK: - Variables
    // MARK: Private
    // MARK: Public
    var router:TabBarRouter
    var interactor:TabBarInteractor
    var view:TabBarViewController
    
    // MARK: - Initializers
    init(router:TabBarRouter,interactor:TabBarInteractor,view:TabBarViewController) {
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
