//
//  CharactersFavoritedPresenter.swift
//  MarvelApp
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
    
    func reload() {
        do {
            try self.interactor.fetchCharacters()
        } catch {
            Logger.logError(in: self, message: error.localizedDescription)
            self.router.showAlertLoadindDataError()
        }
        
        self.view.collectionView?.reloadData()
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
        
        if let data = character.thumbnail?.data {
            let image = UIImage(data: data as Data)
            cell.set(image: image!)
        }
        
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
        let character = self.interactor.characters[indexPath.row]
        self.router.showDetailt(of: character)
    }
}

extension CharactersFavoritedPresenter: CharactersFavoritedCollectionViewCellDelegate {
    func didTapFavorite(value: Bool, in cell: CharactersFavoritedCollectionViewCell) {
        guard let indexPath = self.view.collectionView?.indexPath(for: cell) else {
            Logger.logError(in: self, message: "Could not get the IndexPath of cell ny frame")
            return
        }
        
        self.interactor.removeCharacter(at: indexPath)
    }
}

extension CharactersFavoritedPresenter: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text != nil {
            searchBar.text = ""
            self.interactor.cleanSearch()
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

extension CharactersFavoritedPresenter: CharactersFavoritedInteractorDelegate {
    func didLoad() {
        self.view.collectionView?.reloadData()
    }
    
    func didDelete(at indexPath: IndexPath) {
//        self.view.collectionView?.beginInteractiveMovementForItem(at: indexPath)
        self.view.collectionView?.deleteItems(at: [indexPath])
//        self.view.collectionView?.endInteractiveMovement()
    }
    
    func didFail(error: Error) {
        self.router.showAlert(message: "Thanos is causing some problems in the system. Please try again")
    }
}
