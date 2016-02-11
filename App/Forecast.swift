//
//  Forecast.swift
//  App
//
//  Created by Benoit Verdier on 11/02/2016.
//  Copyright © 2016 3IE. All rights reserved.
//

import Foundation
import ObjectMapper

struct Forecast {
	var code: Int?
	var date: String?
	var highTemperature: Int?
	var lowTemperature: Int?
	var description: String?
}

//MARK: ObjectMapper
extension Forecast: Mappable {
	init?(_ map: Map) {
	}
	
	mutating func mapping(map: Map) {
		code <- (map["code"], IntTransform())
		date <- map["date"]
		lowTemperature <- (map["low"], IntTransform())
		highTemperature <- (map["high"], IntTransform())
		description <- map["text"]
	}
}
