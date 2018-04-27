//
//  DescriptionPresenter.swift
//  XPInvestimento
//
//  Created by Kaique Magno Dos Santos on 26/04/18.
//  Copyright © 2018 Kaique Magno. All rights reserved.
//

import UIKit

class DescriptionPresenter: NSObject {

    
    // MARK: - Variables
    // MARK: Private
    // MARK: Public
    var router:DescriptionRouter
    var interactor:DescriptionInteractor
    var view:DescriptionTableViewCell
    
    // MARK: - Initializers
    init(router:DescriptionRouter,interactor:DescriptionInteractor,view:DescriptionTableViewCell) {
        self.router = router
        self.interactor = interactor
        self.view = view
        
        super.init()
        self.view.presenter = self
        
        self.view.set(description: self.interactor.text)
        self.view.set(image: self.interactor.image)
    }
    
    // MARK: - Functions
    // MARK: Private
    // MARK: Public

    
}
