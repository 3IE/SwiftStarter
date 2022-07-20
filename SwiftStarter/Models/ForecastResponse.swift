//
// Forecast.swift
// iOS-Starter2019
//
// Created by Sofiane Beors on 11/02/2019.
//Copyright © 2019 3ie. All rights reserved.
//

import Foundation
import ObjectMapper

struct ForecastResponse {
    var forecasts: [Forecast]?
}

extension ForecastResponse: Mappable {
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        forecasts <- map["list"]
    }
}

struct Forecast {
    var temperature: Int?
    var weatherInfos: [WeatherInfos]?
    var date: String?
}

extension Forecast: Mappable {
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        temperature <- (map["main.temp"])
        weatherInfos <- map["weather"]
        date <- map["dt_txt"]
    }
}
