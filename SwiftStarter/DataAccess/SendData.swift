//
//  SendData.swift
//  iOS-Starter2019
//
//  Created by Sofiane Beors on 12/02/2019.
//  Copyright © 2019 3ie. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

private enum Router {
    case sendData([String: String])
}

//MARK: - RouterProtocol

extension Router: RouterProtocol {
    var method: HTTPMethod {
        switch self {
        case .sendData(_):
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .sendData(_):
            return "\(Bundle.secondApiBaseUrl)/post"
        }
    }
}

//MARK: URLRequestConvertible

extension Router: URLRequestConvertible {
    func asURLRequest() throws -> URLRequest {
        let urlRequest = try URLRequest(url: self.path, method: self.method)
        switch self {
        case .sendData(let body):
            var request = try Alamofire.JSONEncoding.default.encode(urlRequest, withJSONObject: body)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try! JSONSerialization.data(withJSONObject: body, options: [])
            return request
        }
    }
}

public class SendData {
    static func sendData(data: String, dateSent: Date) async -> SendResponse? {
        await withCheckedContinuation { continuation in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let dateString = dateFormatter.string(from: dateSent)
            let body: [String: String] = ["data": data, "dateSent": dateString]
            
            AF.request(Router.sendData(body)).validate().responseString { response in
                do {
                    let mappedData = try Mapper<SendResponse>().map(JSONString: response.result.get())
                    continuation.resume(returning: mappedData)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
