//
//  UIView+DefaultShadow.swift
//  XPInvestimento
//
//  Created by Kaique Magno Dos Santos on 27/04/18.
//  Copyright © 2018 Kaique Magno. All rights reserved.
//

import UIKit

extension CALayer {
    
    func setShadow(bounds:CGRect?) {
        if let boundsVerified = bounds {
            let ratio:CGFloat = 0.90
            let rect = CGRect(x: (boundsVerified.width*(1-ratio))/2, y: (boundsVerified.height*(1-ratio))/2, width: boundsVerified.width*ratio, height: boundsVerified.height*ratio)
            self.shadowPath = UIBezierPath(roundedRect: rect, cornerRadius: self.cornerRadius).cgPath
            self.shadowColor = UIColor.darkGray.cgColor
            self.shadowOffset = CGSize(width: -8.0, height: 0.0)
            self.shadowOpacity = 0.8
            self.shadowRadius = 5
        } else {
            self.shadowPath = nil
            self.shadowColor = nil
        }
    }

}
