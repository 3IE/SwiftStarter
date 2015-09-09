//
//  ServiceMain.swift
//  App
//
//  Created by Mélanie Bonnet on 09/09/2015.
//  Copyright © 2015 Cédric Eugeni. All rights reserved.
//

import Foundation
import Alamofire

class ServiceMain
{
    internal static func getRootApiUrl() -> String {
        if let apiEndRoot = NSBundle.getRootEndpoint() as String? {
            return apiEndRoot
        } else {
            return ""
        }
    }
    
    internal static func initUrlRequestWithPath(path: String, method: Alamofire.Method) -> NSMutableURLRequest {
        let URL = NSURL(string: NSBundle.getRootEndpoint())!
        let mutableURLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
        mutableURLRequest.HTTPMethod = method.rawValue
        
        return mutableURLRequest
    }
}