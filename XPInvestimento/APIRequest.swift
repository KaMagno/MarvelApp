//
//  APIRequest.swift
//  XPInvestimento
//
//  Created by Kaique Magno Dos Santos on 21/04/18.
//  Copyright © 2018 Kaique Magno. All rights reserved.
//

import CoreData

protocol APIRequest: Encodable {
    associatedtype Response: Decodable 
    
    var endpoint: String { get }
}
