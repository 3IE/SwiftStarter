//
//  TownWithWoeid.swift
//  App
//
//  Created by Benoit Verdier on 10/02/2016.
//  Copyright © 2016 3IE. All rights reserved.
//

import Foundation

protocol TownWithWoeidProtocol {
	var name: String { get }
	var woeid: String { get }
}

enum TownWithWoeid: TownWithWoeidProtocol {
	case paris
	case kremlinBicetre
	
	var name: String {
		switch  self {
		case .paris: return "Paris"
		case .kremlinBicetre : return "Le Kremlin Bicetre"
		}
	}
	
	var woeid: String {
		switch  self {
		case .paris: return "615702"
		case .kremlinBicetre : return "55863504"
		}
	}
}
