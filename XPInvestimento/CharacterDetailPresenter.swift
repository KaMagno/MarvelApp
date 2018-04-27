//
//  CharacterDetailPresenter.swift
//  XPInvestimento
//
//  Created by Kaique Magno Dos Santos on 21/04/18.
//  Copyright © 2018 Kaique Magno. All rights reserved.
//

import UIKit

class CharacterDetailPresenter: NSObject {
    
    // MARK: - Variables
    // MARK: Private
    // MARK: Public
    var router:CharacterDetailRouter
    var interactor:CharacterDetailInteractor
    var view:CharacterDetailTableViewController
    
    // MARK: - Initializers
    init(router:CharacterDetailRouter,interactor:CharacterDetailInteractor,view:CharacterDetailTableViewController) {
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
        self.setFavorite()
    }
    
    func didTapFavorite(value:Bool) {
        self.interactor.setFavorite(value: value)
    }
    
    func setFavorite() {
        self.view.set(isFavorite: self.interactor.isFavorite())
    }
}

extension CharacterDetailPresenter:UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionCell", for: indexPath) as? DescriptionTableViewCell else {
                Logger.logError(in: self, message: "Could not cast cell to DescriptionTableViewCell")
                return UITableViewCell()
            }
            let router = DescriptionRouter(cell: cell, with: self.interactor.character.image ?? #imageLiteral(resourceName: "Nil"), and: self.interactor.character.description ?? "")
            return router.presenter.view
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "HorizontalListCell", for: indexPath) as? HorizontalListTableViewCell else {
                Logger.logError(in: self, message: "Could not cast cell to DescriptionTableViewCell")
                return UITableViewCell()
            }
            let router = HorizontalListRouter(cell: cell, with: self.interactor.comics)
            return router.presenter.view
            
            
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "HorizontalListCell", for: indexPath) as? HorizontalListTableViewCell else {
                Logger.logError(in: self, message: "Could not cast cell to DescriptionTableViewCell")
                return UITableViewCell()
            }
            let router = HorizontalListRouter(cell: cell, with: self.interactor.tvshows)
            return router.presenter.view
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 1:
            return "Comics"
        case 2:
            return "TVShows"
        default:
            return nil
        }
    }
}

extension CharacterDetailPresenter:UITableViewDelegate {
    
}

extension CharacterDetailPresenter:CharacterDetailInteractorDelegate {
    func didLoad(comics: [Comic]) {
        let indexPath = IndexPath(row: 0, section: 1)
        DispatchQueue.main.async {
            self.view.tableView.reloadRows(at: [indexPath], with: .none)
        }
    }
    
    func didLoad(tvshows: [TvShow]) {
        let indexPath = IndexPath(row: 0, section: 2)
        DispatchQueue.main.async {
            self.view.tableView.reloadRows(at: [indexPath], with: .none)
        }
    }
    
    func didFail(error: Error) {
        //TODO:Show alert with error
    }
    
    
}
