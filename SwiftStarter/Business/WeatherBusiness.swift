//
//  WeatherBusiness.swift
//  iOS-Starter2019
//
//  Created by Sofiane Beors on 11/02/2019.
//  Copyright © 2019 3ie. All rights reserved.
//

import Foundation

class WeatherBusiness {
    static func getCurrentWeather(city: CityModel) async -> WeatherResponse? {
        let data = await WeatherData.getCurrentWeather(city: city)
        return data
    }
    
    static func getForecast(forCity city: CityModel) async -> ForecastResponse? {
        let data = await WeatherData.getForecast(city: city)
        return data
    }
}
