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
        self.view.set(empty: self.interactor.characters.count < 1 )
        return self.interactor.characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "default", for: indexPath) as? CharactersCollectionViewCell else {
            Logger.logError(in: self, message: "Could not cast cell to  ")
            return UICollectionViewCell()
        }
        
        cell.delegate = self
        
        let character = self.interactor.characters[indexPath.row]
        cell.set(characterName: character.name ?? "No Name")
        if let url = character.thumbnail?.url {
            cell.set(characterImageURL: url)
        }
        
        let isFavorited = self.interactor.isFavorite(chracter: character)
        cell.set(isFavorite: isFavorited)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if (kind == UICollectionElementKindSectionHeader) {
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "CharactersCollectionReusableView", for: indexPath) as? CharactersCollectionReusableView else {
                Logger.logError(in: self, message: "Could not cast UICollectionReusableView to ChactersCollectionReusableView")
                return UICollectionReusableView()
            }
            
            headerView.outletSearchBar.delegate = self
            
            return headerView
        }
        
        return UICollectionReusableView()
        
    }
}

extension CharactersPresenter: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let character = self.interactor.characters[indexPath.row]
        
        self.router.showDetailt(of: character)
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

extension CharactersPresenter: CharactersCollectionViewCellDelegate {
    func didTapFavorite(value: Bool, in cell: CharactersCollectionViewCell) {
        guard let indexPath = self.view.collectionView?.indexPath(for: cell) else {
            Logger.logError(in: self, message: "Could not get the IndexPath of cell ny frame")
            return
        }
        
        let character = self.interactor.characters[indexPath.row]
        
        self.interactor.setFavorite(value: value, for: character)
        self.view.collectionView?.reloadItems(at: [indexPath])
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

extension CharactersPresenter: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text != nil {
            searchBar.text = ""
            self.interactor.cleanCharacters()
            self.interactor.fetchCharacters()
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            self.interactor.fetchCharacters(nameStartsWith: text)
        }
    }
}
