//
//  File.swift
//  App
//
//  Created by Benoit Verdier on 09/02/2016.
//  Copyright © 2016 3IE. All rights reserved.
//

import Foundation
import ObjectMapper

struct QueryResponse{
	var count: Int?
	var date: NSDate?
	var language: NSString?
	var weatherCondition: WeatherCondition?
	var town: NSString?
}

extension QueryResponse : Mappable {
	init?(_ map: Map) {
		print("salut")
	}
	
	mutating func mapping(map: Map) {
		count <- map["query.count"]
		town <- map["query.results.channel.location.city"]
		date <- (map["query.created"], ISO8601DateTransform())
		language <- map["query.lang"]
		weatherCondition <- map["query.results.channel.item.condition"]
	}
}