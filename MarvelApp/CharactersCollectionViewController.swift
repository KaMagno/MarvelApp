//
//  CharactersViewController.swift
//  MarvelApp
//
//  Created by Kaique Magno Dos Santos on 21/04/18.
//  Copyright © 2018 Kaique Magno. All rights reserved.
//

import UIKit

class CharactersCollectionViewController: UICollectionViewController {
    
    @IBOutlet var outletEmptyBackgroundView: UIView!
    @IBOutlet var outletDefaultBackgroundView: UIView!
    
    var presenter: CharactersPresenter!
    
    // MARK: - UICollectionViewController
    // MARK: Properties
    
    // MARK: Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupRefreshControl()
        self.setupLayout()
        self.presenter.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setupRefreshControl(){
        let refresh = UIRefreshControl()
        refresh.addTarget(presenter, action: #selector(CharactersPresenter.reload), for: .valueChanged)
        refresh.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.collectionView?.refreshControl = refresh
    }
    
    func setupLayout() {
        self.view.backgroundColor = UIColor.init(patternImage: #imageLiteral(resourceName: "BackgroundView"))
        self.collectionView?.backgroundColor = UIColor.init(patternImage: #imageLiteral(resourceName: "BackgroundView"))
        self.collectionView?.backgroundView = self.outletEmptyBackgroundView
        
        guard let flowLayout = self.collectionViewLayout as? UICollectionViewFlowLayout else {
            Logger.logError(in: self, message: "Could not cast \(self.collectionViewLayout) to UICollectionViewFlowLayout")
            return
        }
        let screenWidth = self.view.bounds.width
        _ = self.view.bounds.height
        
        let itemSize:CGFloat = 0.4
        
        //(100% Screen - 2  * % Itens) / 3 Edge Spaces 
        let itemEdge:CGFloat = (1-(itemSize*2))/3
        flowLayout.itemSize = CGSize(width: screenWidth*itemSize, height: screenWidth*itemSize)
        flowLayout.sectionInset = UIEdgeInsets(top: screenWidth*itemEdge, left: screenWidth*itemEdge, bottom: screenWidth*itemEdge, right: screenWidth*itemEdge)
    }
    
    func set(empty:Bool) {
        if empty {
            self.collectionView?.backgroundView = self.outletEmptyBackgroundView
        }else{
            self.collectionView?.backgroundView = self.outletDefaultBackgroundView
        }
    }
}
