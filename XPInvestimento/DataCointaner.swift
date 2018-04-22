//
//  DataCointaner.swift
//  XPInvestimento
//
//  Created by Kaique Magno Dos Santos on 21/04/18.
//  Copyright © 2018 Kaique Magno. All rights reserved.
//

import UIKit

struct DataContainer<Results: Decodable>: Decodable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: Results
    
    public init(offset: Int = 0,
                limit: Int = 0,
                total: Int = 0,
                count: Int = 0,
                results: Results) {
        self.offset = offset
        self.limit = limit
        self.total = total
        self.count = count
        self.results = results
    }
}
