//
//  CharacterDetailViewController.swift
//  XPInvestimento
//
//  Created by Kaique Magno Dos Santos on 21/04/18.
//  Copyright © 2018 Kaique Magno. All rights reserved.
//

import UIKit

class CharacterDetailTableViewController: UITableViewController {

    @IBOutlet var outletBackgroundView: UIView!
    @IBOutlet weak var outletFavoriteButton:UIBarButtonItem!
    
    // MARK: - Properties
    // MARK: Private
    private var isFavorited = false
    // MARK: Public
    var presenter:CharacterDetailPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.tableView.dataSource = self.presenter
        self.tableView.delegate = self.presenter
        
        self.presenter.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupView(){
//        self.tableView.backgroundView = self.outletBackgroundView
        self.tableView.backgroundColor = .white
    }
    
    private func setFavoriteButton(selected:Bool) {
        if selected {
            self.outletFavoriteButton.setBackgroundImage(#imageLiteral(resourceName: "FavortieIcon_Filled"), for: .normal, barMetrics: .default)
        }else{
            self.outletFavoriteButton.setBackgroundImage(#imageLiteral(resourceName: "FavortieIcon"), for: .normal, barMetrics: .default)
        }
    }
    
    func set(title:String) {
        self.title = title
    }
    
    func set(isFavorite:Bool) {
        self.isFavorited = isFavorite
        self.setFavoriteButton(selected: isFavorite)
    }
    
    @IBAction func didTapFavorite(_ sender:UIBarButtonItem) {
        self.presenter.didTapFavorite(value: self.isFavorited)
    }
}
