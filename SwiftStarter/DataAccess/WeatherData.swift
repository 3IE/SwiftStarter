//
// WeatherData.swift
// iOS-Starter2019
//
// Created by Sofiane Beors on 11/02/2019.
//Copyright © 2019 3ie. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

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
            return "\(Bundle.apiBaseUrl)/data/2.5/weather?q=\(String(describing: city.name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!))&appid=\(Bundle.apiKey)&units=metric&lang=fr"
        case .forecast(let city):
            return "\(Bundle.apiBaseUrl)/data/2.5/forecast?q=\(String(describing: city.name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!))&appid=\(Bundle.apiKey)&units=metric&lang=fr"
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
    static func getCurrentWeather(city: CityModel) async -> WeatherResponse? {
        await withCheckedContinuation { continuation in
            AF.request(Router.currentWeather(city)).validate().responseString { response in
                do {
                    let mappedData = try Mapper<WeatherResponse>().map(JSONString: response.result.get())
                    continuation.resume(returning: mappedData)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    
    static func getForecast(city: CityModel) async -> ForecastResponse? {
        await withCheckedContinuation { continuation in
            AF.request(Router.forecast(city)).validate().responseString { response in
                do {
                    let mappedData = try Mapper<ForecastResponse>().map(JSONString: response.result.get())
                    continuation.resume(returning: mappedData)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
