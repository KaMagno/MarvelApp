//
//  ImageManager.swift
//  XPInvestimento
//
//  Created by Kaique Magno Dos Santos on 24/04/18.
//  Copyright © 2018 Kaique Magno. All rights reserved.
//

import UIKit

class ImageManager {

    // MARK: - Properties
    // MARK: Private
    private var cache:NSCache = NSCache<NSString,UIImage>()
    // MARK: Public
    static let shared = ImageManager()
    
    // MARK: - Functions
    // MARK: Private
    // MARK: Public
    func fetchImage(from url:URL, completion: @escaping (UIImage?,Error?) -> Void) {
       
        if let image = self.cache.object(forKey: url.absoluteString as NSString) {
            completion(image,nil)
        }else{
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard
                    let httpURLResponse = response as? HTTPURLResponse,
                    httpURLResponse.statusCode == 200,
                    let data = data,
                    error == nil,
                    let image = UIImage(data: data)
                    else {
                        Logger.logError(in: self, message: "Could not load image")
                        completion(nil,error)
                        return
                }
                
                self.cache.setObject(image, forKey: url.absoluteString as NSString)
                
                completion(image, nil)
                
                }.resume()
        }
    }
    
    func cleanCache() {
        self.cache = NSCache<NSString,UIImage>()
    }
    
}
