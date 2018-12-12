//
//  DescriptionRouter.swift
//  MarvelApp
//
//  Created by Kaique Magno Dos Santos on 26/04/18.
//  Copyright © 2018 Kaique Magno. All rights reserved.
//

import UIKit

class DescriptionRouter: NSObject {
    
    private(set) var presenter:DescriptionPresenter!
    
    init(cell:DescriptionTableViewCell, with image: Thumbnail?, and description: String) {
        //Instancing Variables
        
        super.init()
        
        //Instancing Interactor
        let interactor = DescriptionInteractor(image: image, text: description)
        //Instancing Presenter
        self.presenter = DescriptionPresenter(router: self, interactor: interactor, view: cell)   
    }
}
