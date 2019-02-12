//
// WeatherData.swift
// iOS-Starter2019
//
// Created by Sofiane Beors on 11/02/2019.
//Copyright © 2019 3ie. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

private enum Router {
    case currentWeather(CityModel)
    case forecast(CityModel)
}

//MARK: - RouterProtocol

extension Router: RouterProtocol {
    var method: HTTPMethod {
        switch self {
        case .currentWeather(_), .forecast(_):
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .currentWeather(let city):
            return "\(Bundle.apiBaseUrl)/data/2.5/weather?q=\(String(describing: city.name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!))&APPID=\(Bundle.apiKey)&units=metric&lang=fr"
        case .forecast(let city):
            return "\(Bundle.apiBaseUrl)/data/2.5/forecast?q=\(String(describing: city.name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!))&APPID=\(Bundle.apiKey)&units=metric&lang=fr"
        }
    }
 }

//MARK: URLRequestConvertible

extension Router: URLRequestConvertible {
    func asURLRequest() throws -> URLRequest {
        let urlRequest = try URLRequest(url: self.path, method: self.method)
        switch self {
        default:
            return urlRequest
        }
    }
}

public class WeatherData {
    static func getCurrentWeather(city: CityModel, _ completed: @escaping ((_ response: WeatherResponse?, _ error: NSError?) -> Void)) -> Void {
        Alamofire.request(Router.currentWeather(city)).validate().responseObject { (response: DataResponse<WeatherResponse>) in
            completed(response.result.value, response.result.error as NSError?)
        }
    }
    
    static func getForecast(city: CityModel, _ completed: @escaping ((_ response: ForecastResponse?, _ error: NSError?) -> Void)) -> Void {
        Alamofire.request(Router.forecast(city)).validate().responseObject { (response: DataResponse<ForecastResponse>) in
            completed(response.result.value, response.result.error as NSError?)
        }
    }
}
