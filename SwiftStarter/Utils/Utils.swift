//
//  Utils.swift
//  iOS-Starter2019
//
//  Created by Sofiane Beors on 11/02/2019.
//  Copyright © 2019 3ie. All rights reserved.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
