//
// WeatherResponse.swift
// iOS-Starter2019
//
// Created by Sofiane Beors on 11/02/2019.
//Copyright © 2019 3ie. All rights reserved.
//

import Foundation
import ObjectMapper

struct WeatherResponse {
    var temperature: Int?
    var weatherInfos: [WeatherInfos]?
}

extension WeatherResponse: Mappable {
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        temperature <- map["main.temp"]
        weatherInfos <- map["weather"]
    }
}

struct WeatherInfos {
    var description: String?
}

extension WeatherInfos: Mappable {
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        description <- map["description"]
    }
}
