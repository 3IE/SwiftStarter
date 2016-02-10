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
}

//MARK: RouterProtocol
extension Router: RouterProtocol {
	
	var method: Alamofire.Method {
		switch self {
		case .CurrentWeather:
			return .GET
		}
	}
	
	var path: String {
		switch self {
		case .CurrentWeather(let town):
			return "/v1/public/yql?q=select%20item.condition%2Clocation%2Cunits%20from%20weather.forecast%20where%20woeid%3D\(town.rawValue)%20and%20u%20%3D%20'c'&format=json"
		}
	}
}

//MARK: URLRequestConvertible
extension Router: URLRequestConvertible {
	var URLRequest: NSMutableURLRequest {
		let mutableURLRequest = NSMutableURLRequest(apiPathRelativeToBase: path, method: method)!
		
		switch self {
			//			case .RequestWithParameters(let body):
		//				return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: body).0
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
	static func GetCurrentWeather(forTown town: TownWithWoeid, completed:((response: WeatherQueryResponse?, error: AppError?) -> Void)) -> Void {
		Alamofire.request(Router.CurrentWeather(town))
			.validate()
			.responseObject { (alamoResponse: Response<WeatherQueryResponse, NSError>) in
				let appError: AppError? = AppError(response: alamoResponse)
				let queryResponse: WeatherQueryResponse? = alamoResponse.result.value
				completed(response: queryResponse, error: appError)
		}
		
	}
}