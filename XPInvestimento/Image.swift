//
//  Image.swift
//  XPInvestimento
//
//  Created by Kaique Magno Dos Santos on 21/04/18.
//  Copyright © 2018 Kaique Magno. All rights reserved.
//

import UIKit

struct Image: Decodable {
    private enum Keys: String, CodingKey {
        case path = "path"
        case fileExtension = "extension"
    }
    
    let url: URL
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        
        let path = try container.decode(String.self, forKey: .path)
        let fileExtension = try container.decode(String.self, forKey: .fileExtension)
        
        guard let url = URL(string: "\(path).\(fileExtension)") else { throw APIError.decoding }
        
        self.url = url
    }
}
