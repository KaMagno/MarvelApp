//
//  NavigationViewController.swift
//  MarvelApp
//
//  Created by Kaique Magno Dos Santos on 24/04/18.
//  Copyright © 2018 Kaique Magno. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController {
    
    var presenter:NavigationPresenter!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.navigationBar.prefersLargeTitles = true
        self.navigationBar.isTranslucent = true
        self.navigationBar.barTintColor = .black
        self.navigationBar.tintColor = .white
        self.navigationBar.backgroundColor = .black
        self.navigationBar.largeTitleTextAttributes = [
            NSAttributedStringKey.font: UIFont(name: "Impact", size: 40.0) ?? UIFont.systemFont(ofSize: 60.0),
            NSAttributedStringKey.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
        ]
        self.navigationBar.titleTextAttributes = [
            NSAttributedStringKey.font: UIFont(name: "Impact", size: 20.0) ?? UIFont.systemFont(ofSize: 20.0),
            NSAttributedStringKey.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        ]
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

