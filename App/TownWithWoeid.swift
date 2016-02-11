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
	case Paris
	case KremlinBicetre
	
	var name: String {
		switch  self {
		case .Paris: return "Paris"
		case .KremlinBicetre : return "Le Kremlin Bicetre"
		}
	}
	var woeid: String {
		switch  self {
		case .Paris: return "615702"
		case .KremlinBicetre : return "55863504"
		}
	}
}
