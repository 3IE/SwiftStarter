//
//  CityModel.swift
//  iOS-Starter2019
//
//  Created by Sofiane Beors on 11/02/2019.
//  Copyright © 2019 3ie. All rights reserved.
//

import Foundation

protocol CityProtocol {
    var name: String { get }
    var coords: [String: Double] { get }
}

enum CityModel: CityProtocol {
    case paris
    case kremlinBicetre
    
    var name: String {
        switch self {
        case .paris: return "Paris"
        case .kremlinBicetre : return "Le Kremlin-Bicetre"
        }
    }
    
    var coords: [String : Double] {
        switch self {
        case .paris:
            return ["lat": 48.864716, "long": 2.349014]
        case .kremlinBicetre:
            return ["lat": 48.81471, "long": 2.36073]
        }
    }
}
