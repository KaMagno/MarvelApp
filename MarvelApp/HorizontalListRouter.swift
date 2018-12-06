//
//  HorizontalListRouter.swift
//  XPInvestimento
//
//  Created by Kaique Magno Dos Santos on 26/04/18.
//  Copyright © 2018 Kaique Magno. All rights reserved.
//

import UIKit

class HorizontalListRouter: NSObject {

    private(set) var presenter:HorizontalListPresenter!
    
    init(cell:HorizontalListTableViewCell,with objects: [HorizontalListObject]) {
        super.init()
        
        //Instancing Interactor
        let interactor = HorizontalListInteractor(objects: objects)
        //Instancing Presenter
        self.presenter = HorizontalListPresenter(router: self, interactor: interactor, view: cell)
    }
}
