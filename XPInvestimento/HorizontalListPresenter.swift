//
//  HorizontalListPresenter.swift
//  XPInvestimento
//
//  Created by Kaique Magno Dos Santos on 26/04/18.
//  Copyright © 2018 Kaique Magno. All rights reserved.
//

import UIKit

class HorizontalListPresenter: NSObject {
    
    // MARK: - Variables
    // MARK: Private
    // MARK: Public
    var router:HorizontalListRouter
    var interactor:HorizontalListInteractor
    var view:HorizontalListTableViewCell
    
    // MARK: - Initializers
    init(router:HorizontalListRouter,interactor:HorizontalListInteractor,view:HorizontalListTableViewCell) {
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

extension HorizontalListPresenter:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.interactor.objects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "default", for: indexPath) as? HorizontalListCollectionViewCell else {
            Logger.logError(in: self, message: "Could not cast to HorizontalListTableViewCell")
            return UICollectionViewCell()
        }
        
        let object = self.interactor.objects[indexPath.row]
        cell.outletTitle.text = object.getName()
        cell.outletImage.image = object.getImage()
    }
}

extension HorizontalListPresenter:UICollectionViewDelegate {
    
}
