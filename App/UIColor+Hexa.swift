//
//  UIColor+hexa.swift
//  App
//
//  Created by Cédric Eugeni on 03/06/2015.
//  Copyright (c) 2015 Cédric Eugeni. All rights reserved.
//

import UIKit

public extension UIColor {
    public convenience init?(rgbValue: UInt) {
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0) 
        )
    }
}