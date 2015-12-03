//
//  AppError.swift
//  App
//
//  Created by Mélanie Bonnet on 09/09/2015.
//  Copyright © 2015 Cédric Eugeni. All rights reserved.
//

import Foundation
import Argo
import Curry

public enum AppError: ErrorType {
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
            return "[ARGO] app Type Mismatch : expected " + expected + ", actual " + actual
        case .MissingKey(let message):
            return "[ARGO] app missing key : " + message
        case .Server(_, let message):
            return getDomain() + message
        default:
            return "[ARGO] app : "
        }
    }
}

extension AppError : Decodable {
    public static func decode(j: JSON) -> Decoded<AppError> {
        return curry(AppError.Server)
            <^> j <| "code"
            <*> j <| "message"
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