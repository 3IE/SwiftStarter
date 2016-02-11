//
//  File.swift
//  App
//
//  Created by Benoit Verdier on 09/02/2016.
//  Copyright © 2016 3IE. All rights reserved.
//

import Foundation
import ObjectMapper

struct CurrentWeatherResponse {
	var count: Int?
	var town: String?
	var date: NSDate?
	var language: String?
	var weatherCondition: WeatherCondition?
	
}

extension CurrentWeatherResponse: Mappable {
	init?(_ map: Map) {
	}
	
	mutating func mapping(map: Map) {
		count <- map["query.count"]
		town <- map["query.results.channel.location.city"]
		date <- (map["query.created"], ISO8601DateTransform())
		language <- map["query.lang"]
		weatherCondition <- map["query.results.channel.item.condition"]
	}
}
