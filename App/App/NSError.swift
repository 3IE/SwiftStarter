//
//  NSError+Argo.swift
//  App
//
//  Created by Cédric Eugeni on 05/06/2015.
//  Copyright (c) 2015 Cédric Eugeni. All rights reserved.
//

import Foundation
import Argo
import Runes

public enum ErrorType {
    case NoResponse
    case Parsing
    case TypeMismatch
    case MissingKey
    
    var code: Int {
        switch self {
        default:
            return -100
        }
    }
    
    var message: String {
        switch self {
        case .TypeMismatch:
            return "app Type Mismatch : "
        case .MissingKey:
            return "app missing key : "
        default:
            return "app : "
        }
    }
}

extension NSError {
    public convenience init(error: ErrorType, message: String) {
        let domain: String = getDomain()
        self.init(domain: domain, code: error.code, userInfo: nil)
        
        self.setValue(error.message + message, forKey: NSLocalizedDescriptionKey)
    }
}

extension NSError: Decodable {
    static func create(code: Int)(message: String) -> NSError {
        let domain: String = getDomain()
        return NSError(domain: domain, code: code, userInfo: ["server": message])
    }
    
    public static func decode(json: JSON) -> Decoded<NSError> {
        return NSError.create
            <^> json <| "code"
            <*> json <| "message"
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