//
//  NSURLRequest+Body.swift
//  App
//
//  Created by Cédric Eugeni on 08/06/2015.
//  Copyright (c) 2015 Cédric Eugeni. All rights reserved.
//

import Foundation
import Alamofire

public extension NSMutableURLRequest {
    public convenience init?(path: String, method: Alamofire.Method) {
        let URL = NSURL(string: NSURL.getRootEndpoint())!
        self.init(URL: URL.URLByAppendingPathComponent(path))
        
        self.HTTPMethod = method.rawValue
        //Add here some other settings for your request
    }
}