//
//  AppError.swift
//  App
//
//  Created by Mélanie Bonnet on 09/09/2015.
//  Copyright © 2015 3IE. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire

/**
The various kind of app errors

- NoResponse: the server did not respond
- Parsing:    the server responded but the response could not be parsed
- Server:     the server responded a custom error message
*/
enum AppError: Error {
    case noResponse(String)
    case parsing(String)
    case server(Int, String)
    
    var code: Int {
        switch self {
        case .server(let code, _):
            return code
        default:
            return -100
        }
    }
    
    var message: String {
        switch self {
        case .server(_, let message):
            return getDomain() + message
        default:
            return "[parsing] app : "
        }
    }
}

//MARK: - AlamoFire

extension AppError {
	init?<T>(response: Alamofire.DataResponse<T>) {
		if (response.response == nil) {
			self = .noResponse("No Response")
		}
		else if (response.result.isFailure || response.result.value == nil) {
			self = .parsing("Parsing failure")
		}
		else {
			return nil
		}
	}
}


//MARK: - ObjectMapper

extension AppError : Mappable {
	init?(map: Map) {
		self = .server(0, "msg")
	}
	
	mutating func mapping(map: Map) {
		var parsedMessage : String = ""
		var parsedCode : Int = 0
		parsedMessage <- map["message"]
		parsedCode <- map["code"]
		self = .server(parsedCode, parsedMessage)
	}
}

//MARK: - Helpers

private func getDomain() -> String {
    if let domain: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleIdentifier") as? String {
        return domain
    } else {
        return ""
    }
}
