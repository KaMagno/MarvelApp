//
//  CharactersPresenter.swift
//  XPInvestimento
//
//  Created by Kaique Magno Dos Santos on 21/04/18.
//  Copyright © 2018 Kaique Magno. All rights reserved.
//

import UIKit

class CharactersPresenter: NSObject {

    // MARK: - Properties
    // MARK: Private
    // MARK: Public
    var router:CharactersRouter
    var interactor:CharactersInteractor
    var view:CharactersCollectionViewController
    
    // MARK: - Initializers
    init(router:CharactersRouter,interactor:CharactersInteractor,view:CharactersCollectionViewController) {
        self.router = router
        self.interactor = interactor
        self.view = view
        
        super.init()
        self.view.presenter = self
        self.interactor.delegate = self
    }
    
    // MARK: - Functions
    // MARK: Private
    // MARK: Public
    func viewDidLoad() {
        self.view.collectionView?.dataSource = self
        self.view.collectionView?.delegate = self
        
        self.interactor.fetchCharacters()
    }
    
    @objc func reload() {
        self.interactor.fetchCharacters()
    }
}

extension CharactersPresenter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.interactor.characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "default", for: indexPath) as? CharactersCollectionViewCell else {
            Logger.logError(in: self, message: "Could not cast cell to  ")
            return UICollectionViewCell()
        }
        
        let character = self.interactor.characters[indexPath.row]
        cell.set(characterName: character.name ?? "No Name")
        if let url = character.thumbnail?.url {
            cell.set(characterImageURL: url)
        }
        cell.set(isFavorite: character.isFavorited)
        
        return cell
    }
    
}

extension CharactersPresenter: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "default", for: indexPath) as? CharactersCollectionViewCell else {
            Logger.logError(in: self, message: "Could not cast cell to  ")
            return
        }
        cell.cleanData()
        
        if self.interactor.characters.count-10 == indexPath.row {
            self.interactor.fetchCharacters(offset: indexPath.row)
        }
    }
    
    
}

extension CharactersPresenter:CharactersCollectionViewCellDelegate {
    func didTapFavorite(in frame: CGRect) {
        guard let indexPath = self.view.collectionView?.indexPathForItem(at: frame.origin) else {
            Logger.logError(in: self, message: "Could not get the IndexPath of cell ny frame")
            return
        }
        
        let character = self.interactor.characters[indexPath.row]
        self.interactor.setFavoriteStatus(for: character)
    }
}

extension CharactersPresenter: CharactersInteractorDelegate {
    func isLoading(_ loading:Bool) {
        
    }
    func didLoad(characters: [Character]) {
        DispatchQueue.main.async {
            self.view.collectionView?.reloadData()
            self.view.collectionView?.refreshControl?.endRefreshing()
        }
    }
    func didFail(error: Error) {
        //TODO: Error Screen View
    }
}
