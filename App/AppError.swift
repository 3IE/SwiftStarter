//
//  AppError.swift
//  App
//
//  Created by Mélanie Bonnet on 09/09/2015.
//  Copyright © 2015 3IE. All rights reserved.
//

import Foundation
import ObjectMapper

enum AppError: ErrorType {
    case NoResponse(String)
    case Parsing(String)
    case TypeMismatch(String, String)
    case MissingKey(String)
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
        case .TypeMismatch(let expected, let actual):
            return "[parsing] app Type Mismatch : expected " + expected + ", actual " + actual
        case .MissingKey(let message):
            return "[parsing] app missing key : " + message
        case .Server(_, let message):
            return getDomain() + message
        default:
            return "[parsing] app : "
        }
    }
}

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
