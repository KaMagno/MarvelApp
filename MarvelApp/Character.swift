//
//  Character.swift
//  MarvelApp
//
//  Created by Kaique Magno Dos Santos on 12/12/18.
//  Copyright © 2018 Kaique Magno. All rights reserved.
//

import UIKit

struct Character: Decodable {

    let characterDescription: String?
    let id: Int
    let name: String?
    var thumbnail: Thumbnail?
    
    init(favoriteCharacter:FavoriteCharacter) {
        self.id = Int(favoriteCharacter.id)
        self.name = favoriteCharacter.name
        self.characterDescription = favoriteCharacter.characterDescription
        
        if let thumbnail = favoriteCharacter.thumbnail {
            self.thumbnail = Thumbnail(favoriteThumbnail: thumbnail)
        }else{
            self.thumbnail = nil
        }
    }
}
