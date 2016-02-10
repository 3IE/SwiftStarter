
//
//  WeatherBusiness.swift
//  App
//
//  Created by Benoit Verdier on 09/02/2016.
//  Copyright © 2016 3IE. All rights reserved.
//

import Foundation

class WeatherBusiness {
	
	static func GetWeather(forTown town: TownWithWoeid, completed:((response:WeatherQueryResponse?, error: AppError?) -> Void)) -> Void {
		WeatherData.GetCurrentWeather(forTown: town) { (response, error) in
			completed(response: response, error: error)
		}
	}
	
}
