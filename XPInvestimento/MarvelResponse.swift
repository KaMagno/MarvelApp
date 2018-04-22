//
//  MarvelResponse.swift
//  XPInvestimento
//
//  Created by Kaique Magno Dos Santos on 21/04/18.
//  Copyright © 2018 Kaique Magno. All rights reserved.
//

import UIKit

struct MarvelResponse<Response: Decodable>: Decodable {
    let status: String?
    let message: String?
    let data: DataContainer<Response>?
}

