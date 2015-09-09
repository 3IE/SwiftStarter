//
//  NSURLRequest+Body.swift
//  App
//
//  Created by Cédric Eugeni on 08/06/2015.
//  Copyright (c) 2015 Cédric Eugeni. All rights reserved.
//

import Foundation
import Alamofire

internal extension NSMutableURLRequest {
    internal convenience init?(path: String, method: Alamofire.Method) {
        let URL = NSURL(string: NSBundle.getRootEndpoint())!
        self.init(URL: URL.URLByAppendingPathComponent(path))
        
        self.HTTPMethod = method.rawValue
        //Add here some other settings for your request
    }
}