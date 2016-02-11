//
//  WeatherData.swift
//  App
//
//  Created by Benoit Verdier on 09/02/2016.
//  Copyright © 2016 3IE. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

//MARK: Router class
private enum Router {
	case CurrentWeather(TownWithWoeid)
	case Forecast(TownWithWoeid)
}

//MARK: RouterProtocol
extension Router: RouterProtocol {
	
	var method: Alamofire.Method {
		switch self {
		case .CurrentWeather:
			return .GET
		case .Forecast:
			return .GET
		}
	}
	
	var path: String {
		switch self {
		case .CurrentWeather(let town):
			return "/v1/public/yql?q=select%20item.condition%2Clocation%2Cunits%20from%20weather.forecast%20where%20woeid%3D\(town.woeid)%20and%20u%20%3D%20'c'&format=json"
		case .Forecast(let town):
			return "/v1/public/yql?q=select%20item%2Clocation%2Cunits%20from%20weather.forecast%20where%20woeid%3D\(town.woeid)%20and%20u%20%3D%20'c'&format=json"
		}
	}
}

//MARK: URLRequestConvertible
extension Router: URLRequestConvertible {
	var URLRequest: NSMutableURLRequest {
		guard let mutableURLRequest = NSMutableURLRequest(apiPathRelativeToBase: self.path, method: self.method) else {
			return NSMutableURLRequest()
		}		
		switch self {
		default:
			return mutableURLRequest
		}
	}
}

//MARK: - WeatherData
class WeatherData {
	
	/**
	Fetch the current weather
	
	- parameter town:      town to fetch the weather from
	- parameter completed: completion block; error is nil is everthing goes right
	*/
	static func GetCurrentWeather(forTown town: TownWithWoeid, completed:((response: CurrentWeatherResponse?, error: AppError?) -> Void)) -> Void {
		Alamofire.request(Router.CurrentWeather(town))
			.validate()
			.responseObject { (alamoResponse: Response<CurrentWeatherResponse, NSError>) in
				completed(response: alamoResponse.result.value, error: AppError(response: alamoResponse))
		}
	}
	
	/**
	Fetch the forecast for the next few days
	
	- parameter town:      town to fetch the weather from
	- parameter completed: completion block; error is nil is everthing goes right
	*/
	static func GetForecast(forTown town: TownWithWoeid, completed:((response: ForecastResponse?, error: AppError?) -> Void)) -> Void {
		Alamofire.request(Router.Forecast(town))
			.validate()
			.responseObject { (alamoResponse: Response<ForecastResponse, NSError>) in
				completed(response: alamoResponse.result.value, error: AppError(response: alamoResponse))
		}
	}
}
