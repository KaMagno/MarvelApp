//
//  Constants.swift
//  MarvelApp
//
//  Created by Kaique Magno Dos Santos on 21/04/18.
//  Copyright © 2018 Kaique Magno. All rights reserved.
//

import UIKit

final class Constants {
    
    final class MarvelAPI {
        static let baseEndpoint:String = "https://gateway.marvel.com:443/v1/public/"
        static let privateKey:String = "4aef6aeeb34bc46d828766d915931467aead6d6c"
        static let publicKey:String = "f971fc5cb921036c6c40587d679b85ad"
        static let ts = Date().timeIntervalSince1970
        static var hash:String {
            let string = "\(MarvelAPI.ts)\(MarvelAPI.privateKey)\(MarvelAPI.publicKey)"
            
            return string.md5
        }
        
        static let offset = 20
    }
    
}
