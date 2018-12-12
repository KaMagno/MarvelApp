//
//  APIError.swift
//  MarvelApp
//
//  Created by Kaique Magno Dos Santos on 21/04/18.
//  Copyright © 2018 Kaique Magno. All rights reserved.
//

import UIKit

extension APIManager {
    enum APIError: Error {
        case encoding
        case decoding
        case server(message: String)
    }
}


