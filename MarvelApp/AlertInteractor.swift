//
//  AlertInteractor.swift
//  MarvelApp
//
//  Created by Kaique Magno Dos Santos on 24/04/18.
//  Copyright © 2018 Kaique Magno. All rights reserved.
//

import UIKit

class AlertInteractor: NSObject {

    var message:String
    var buttonTitle:String
    
    init(message:String,buttonTitle:String) {
        self.message = message
        self.buttonTitle = buttonTitle
    }
}
