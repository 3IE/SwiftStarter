//
//  ForecastResponse.swift
//  App
//
//  Created by Benoit Verdier on 11/02/2016.
//  Copyright © 2016 3IE. All rights reserved.
//

import Foundation
import ObjectMapper

struct ForecastResponse {
	var count: Int?
	var town: String?
	var date: Date?
	var language: String?
	var forecasts: [Forecast]?
	
}

extension ForecastResponse: Mappable {
	init?(map: Map) {
	}
	
	mutating func mapping(map: Map) {
		count <- map["query.count"]
		town <- map["query.results.channel.location.city"]
		date <- (map["query.created"], ISO8601DateTransform())
		language <- map["query.lang"]
		forecasts <- map["query.results.channel.item.forecast"]
	}
}
