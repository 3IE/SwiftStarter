//
//  WeatherBusiness.swift
//  iOS-Starter2019
//
//  Created by Sofiane Beors on 11/02/2019.
//  Copyright © 2019 3ie. All rights reserved.
//

import Foundation

class WeatherBusiness {
    static func getCurrentWeather(forCity city: CityModel, completed: @escaping ((_ response: WeatherResponse?, _ error: Error?) -> Void)) -> Void {
        WeatherData.getCurrentWeather(city: city) { (response, error) in
            completed(response, error)
        }
    }
    
    static func getForecast(forCity city: CityModel, completed: @escaping ((_ response: ForecastResponse?, _ error: Error?) -> Void)) -> Void {
        WeatherData.getForecast(city: city) { (response, error) in
            completed(response, error)
        }
    }
}
