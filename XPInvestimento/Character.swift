//
//  Character.swift
//  XPInvestimento
//
//  Created by Kaique Magno Dos Santos on 21/04/18.
//  Copyright © 2018 Kaique Magno. All rights reserved.
//

import UIKit

public struct Character: Decodable {
    let id: Int
    let name: String?
    let description: String?
    let thumbnail: Image?
    let image:UIImage?
    var isFavorited:Bool
    
    enum Keys:String,CodingKey {
        case id
        case name
        case description
        case thumbnail
    }
    
    // MARK: - Inits
    public init(id: Int = 0,
                name: String? = nil,
                description: String? = nil,
                thumbnail: Image? = nil,
                image: UIImage? = nil,
                isFavorited: Bool = false) {
        self.id = id
        self.name = name
        self.description = description
        self.thumbnail = thumbnail
        self.image = image
        self.isFavorited = isFavorited
    }
    
    public init(characterFavorited:CharacterFavorited) {
        self.id = characterFavorited.id
        self.name = characterFavorited.name
        self.description = characterFavorited.characterDescription
        self.thumbnail = Image.init(url: characterFavorited.image?.url)
        
        if let imageDataVerified = characterFavorited.image?.imageData {
            self.image = UIImage(data: imageDataVerified as Data)
        }else{
            self.image = nil
        }
        
        self.isFavorited = true
    }
    
    // MARK: Decodable
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.description = try container.decode(String.self, forKey: .description)
        self.thumbnail = try container.decode(Image.self, forKey: .thumbnail)
        self.image = nil
        self.isFavorited = false
    }
}

extension Character:Equatable {
    public static func == (lhs: Character, rhs: Character) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name && lhs.description == rhs.description && lhs.thumbnail?.url == rhs.thumbnail?.url
    }
}
