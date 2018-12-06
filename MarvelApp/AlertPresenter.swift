//
//  AlertPresenter.swift
//  XPInvestimento
//
//  Created by Kaique Magno Dos Santos on 24/04/18.
//  Copyright © 2018 Kaique Magno. All rights reserved.
//

import UIKit

class AlertPresenter: NSObject {
    
    // MARK: - Variables
    // MARK: Private
    // MARK: Public
    var router:AlertRouter
    var interactor:AlertInteractor
    var view:AlertViewController
    
    // MARK: - Initializers
    init(router:AlertRouter,interactor:AlertInteractor,view:AlertViewController) {
        self.router = router
        self.interactor = interactor
        self.view = view
        
        super.init()
        self.view.presenter = self
    }
    
    // MARK: - Functions
    // MARK: Private
    // MARK: Public
    func viewDidLoad() {
        self.view.set(message: self.interactor.message)
        self.view.set(buttonTitle: self.interactor.buttonTitle)
    }
    
    func didTapCancel() {
        self.router.dismiss()
    }
    func didTapConfirm() {
        self.router.dismiss()
    }
}
