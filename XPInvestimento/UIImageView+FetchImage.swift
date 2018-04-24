//
//  UIImage+FetchImage.swift
//  XPInvestimento
//
//  Created by Kaique Magno Dos Santos on 24/04/18.
//  Copyright © 2018 Kaique Magno. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func fetchImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse,
                httpURLResponse.statusCode == 200,
                let data = data,
                error == nil,
                let image = UIImage(data: data)
                else {
                    Logger.logError(in: self, message: "Could not load image")
                    return
            }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    
}
