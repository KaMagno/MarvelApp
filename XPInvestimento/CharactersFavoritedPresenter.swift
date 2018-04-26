//
//  CharactersFavoritedPresenter.swift
//  XPInvestimento
//
//  Created by Kaique Magno Dos Santos on 26/04/18.
//  Copyright © 2018 Kaique Magno. All rights reserved.
//

import UIKit

class CharactersFavoritedPresenter: NSObject {

    // MARK: - Properties
    // MARK: Private
    // MARK: Public
    var router:CharactersFavoritedRouter
    var interactor:CharactersFavoritedInteractor
    var view:CharactersFavoritedCollectionViewController
    
    // MARK: - Initializers
    init(router:CharactersFavoritedRouter,interactor:CharactersFavoritedInteractor,view:CharactersFavoritedCollectionViewController) {
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
        
        self.reload()
    }
    
    @objc func reload() {
        do {
            try self.interactor.fetchCharacters()
        } catch {
            Logger.logError(in: self, message: error.localizedDescription)
            self.router.showAlertLoadindDataError()
        }
    }
}

extension CharactersFavoritedPresenter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.view.set(empty: self.interactor.characters.count < 1 )
        return self.interactor.characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "default", for: indexPath) as? CharactersFavoritedCollectionViewCell else {
            Logger.logError(in: self, message: "Could not cast cell to  ")
            return UICollectionViewCell()
        }
        
        cell.delegate = self
        
        let character = self.interactor.characters[indexPath.row]
        cell.set(characterName: character.name ?? "No Name")
//        if let url = character.thumbnail?.url {
//            cell.set(characterImageURL: url)
//        }
        cell.set(isFavorite: true)
        
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

extension CharactersFavoritedPresenter: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension CharactersFavoritedPresenter: CharactersFavoritedCollectionViewCellDelegate {
    func didTapFavorite(value: Bool, in cell: CharactersFavoritedCollectionViewCell) {
        guard let indexPath = self.view.collectionView?.indexPath(for: cell) else {
            Logger.logError(in: self, message: "Could not get the IndexPath of cell ny frame")
            return
        }
        
        let character = self.interactor.characters[indexPath.row]
        
        self.interactor.remove(characterFavorited: character)
        DispatchQueue.main.async {
            self.view.collectionView?.reloadData()
        }
    }
}

extension CharactersFavoritedPresenter: CharactersFavoritedInteractorDelegate {
    func isLoading(_ loading:Bool) {
        
    }
    
    func didLoad(characters: [Character]) {
        DispatchQueue.main.async {
            self.view.collectionView?.reloadData()
            self.view.collectionView?.refreshControl?.endRefreshing()
        }
    }
    
    func didFail(error: Error) {
        self.router.showAlertLoadindDataError()
    }
}

extension CharactersFavoritedPresenter: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text != nil {
            searchBar.text = ""
            self.interactor.cleanCharacters()
            self.reload()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            do{
                try self.interactor.fetchCharacters(nameStartsWith: text)
            }catch{
                Logger.logError(in: self, message: error.localizedDescription)
                self.router.showAlertLoadindDataError()
            }
        }
    }
}
