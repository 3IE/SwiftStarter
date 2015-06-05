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

extension NSError: Decodable {
    static func create(code: Int)(message: String) -> NSError {
        return NSError(domain: "", code: code, userInfo: ["server": message])
    }
    
    public static func decode(json: JSON) -> Decoded<NSError> {
        return NSError.create
            <^> json <| "code"
            <*> json <| "message"
    }
}