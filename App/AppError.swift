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
enum AppError: ErrorType {
    case NoResponse(String)
    case Parsing(String)
    case Server(Int, String)
    
    var code: Int {
        switch self {
        case .Server(let code, _):
            return code
        default:
            return -100
        }
    }
    
    var message: String {
        switch self {
        case .Server(_, let message):
            return getDomain() + message
        default:
            return "[parsing] app : "
        }
    }
}

//MARK: - AlamoFire

extension AppError {
	init?<T>(response: Alamofire.Response<T, NSError>) {
		if (response.response == nil) {
			self = .NoResponse("No Response")
		}
		else if (response.result.isFailure || response.result.value == nil) {
			self = .Parsing("Parsing failure")
		}
		else {
			return nil
		}
	}
}


//MARK: - ObjectMapper

extension AppError : Mappable {
	init?(_ map: Map) {
		self = .Server(0, "msg")
	}
	
	mutating func mapping(map: Map) {
		var parsedMessage : String = ""
		var parsedCode : Int = 0
		parsedMessage <- map["message"]
		parsedCode <- map["code"]
		self = .Server(parsedCode, parsedMessage)
	}
}

//MARK: - Helpers

private func getDomain() -> String {
    if let domain: String = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleIdentifier") as? String {
        return domain
    } else {
        return ""
    }
}
