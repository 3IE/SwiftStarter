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

enum TownWithWoeid: String {
	case Paris = "615702"
	case KremlinBicetre = "55863504"
}

class WeatherData: DataAccessMain {
	
	private enum Router: URLRequestConvertible {
		case CurrentWeather(TownWithWoeid)
		
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
		
		var URLRequest: NSMutableURLRequest {
			let mutableURLRequest = DataAccessMain.initUrlRequestWithPath(path, method: method)
			
			switch self {
//			case .RequestWithParameters(let body):
//				return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: body).0
			default:
				return mutableURLRequest
			}
		}
	}

	static func GetCurrentWeather(forTown town: TownWithWoeid, completed:((response:QueryResponse?, error: AppError?) -> Void)) -> Void {
		Alamofire.request(Router.CurrentWeather(town))
			.validate()
			.responseObject { (response: Response<QueryResponse, NSError>) in
				let appError: AppError?
				let queryResponse: QueryResponse? = response.result.value
				if (response.response == nil) {
					appError = AppError.NoResponse("No Response")
				}
				else if (response.result.isFailure || response.result.value == nil) {
					appError = AppError.Parsing("Parsing failure")
				}
				else {
					appError = nil
				}
				completed(response: queryResponse, error: appError)
		}

	}
}