
//
//  WeatherBusiness.swift
//  App
//
//  Created by Benoit Verdier on 09/02/2016.
//  Copyright © 2016 3IE. All rights reserved.
//

import Foundation

class WeatherBusiness {
	
	static func GetWeather(forTown town: TownWithWoeid, completed:((response:CurrentWeatherResponse?, error: AppError?) -> Void)) -> Void {
		WeatherData.GetCurrentWeather(forTown: town) { (response, error) in
			completed(response: response, error: error)
		}
	}
	
	static func GetForecast(forTown town: TownWithWoeid, completed:((response:ForecastResponse?, error: AppError?) -> Void)) -> Void {
		WeatherData.GetForecast(forTown: town) { (response, error) in
			completed(response: response, error: error)
		}
	}
	
}
