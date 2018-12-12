//
//  Thumbnail.swift
//  MarvelApp
//
//  Created by Kaique Magno Dos Santos on 12/12/18.
//  Copyright © 2018 Kaique Magno. All rights reserved.
//

import UIKit

struct Thumbnail: Decodable {

    private enum Keys: String, CodingKey {
        case path = "path"
        case fileExtension = "extension"
    }
    
    let url: URL?
    var image:UIImage = #imageLiteral(resourceName: "Nil")
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: Keys.self)
        let path = try values.decode(String.self, forKey: .path)
        let fileExtension = try values.decode(String.self, forKey: .fileExtension)
        self.url = URL(string: "\(path).\(fileExtension)")
    }
    
    init(favoriteThumbnail:FavoriteThumbnail) {
        self.url = URL(string: favoriteThumbnail.url ?? "")
        if let data = favoriteThumbnail.data,
            let image = UIImage(data: data as Data) {
            self.image = image
        }
    }
}
