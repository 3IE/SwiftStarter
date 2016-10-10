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
	case currentWeather(TownWithWoeid)
	case forecast(TownWithWoeid)
}

//MARK: RouterProtocol
extension Router: RouterProtocol {
	
	var method: Alamofire.HTTPMethod {
		switch self {
		case .currentWeather:
			return .get
		case .forecast:
			return .get
		}
	}
	
	var path: String {
		switch self {
		case .currentWeather(let town):
			return "\(Bundle.apiBaseUrl)/v1/public/yql?q=select%20item.condition%2Clocation%2Cunits%20from%20weather.forecast%20where%20woeid%3D\(town.woeid)%20and%20u%20%3D%20'c'&format=json"
		case .forecast(let town):
			return "\(Bundle.apiBaseUrl)/v1/public/yql?q=select%20item%2Clocation%2Cunits%20from%20weather.forecast%20where%20woeid%3D\(town.woeid)%20and%20u%20%3D%20'c'&format=json"
		}
	}
}

//MARK: URLRequestConvertible
extension Router: URLRequestConvertible {
    /// Returns a URL request or throws if an `Error` was encountered.
    ///
    /// - throws: An `Error` if the underlying `URLRequest` is `nil`.
    ///
    /// - returns: A URL request.
    public func asURLRequest() throws -> URLRequest {
    
        var urlRequest = URLRequest(url: URL(string: self.path)!)
        urlRequest.httpMethod = self.method.rawValue
        
        switch self {
        default:
            return urlRequest
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
	static func GetCurrentWeather(forTown town: TownWithWoeid, completed:@escaping ((_ response: CurrentWeatherResponse?, _ error: Error?) -> Void)) -> Void {
		Alamofire.request(Router.currentWeather(town))
			.validate()
			.responseObject { (alamoResponse: DataResponse<CurrentWeatherResponse>) in
                completed(alamoResponse.result.value, alamoResponse.result.error)
		}
	}
	
	/**
	Fetch the forecast for the next few days
	
	- parameter town:      town to fetch the weather from
	- parameter completed: completion block; error is nil is everthing goes right
	*/
	static func GetForecast(forTown town: TownWithWoeid, completed:@escaping ((_ response: ForecastResponse?, _ error: Error?) -> Void)) -> Void {
		Alamofire.request(Router.forecast(town))
			.validate()
			.responseObject { (alamoResponse: DataResponse<ForecastResponse>) in
				completed(alamoResponse.result.value, alamoResponse.result.error)
		}
	}
}
