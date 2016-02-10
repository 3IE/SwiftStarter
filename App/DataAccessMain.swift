//
//  ServiceMain.swift
//  App
//
//  Created by Mélanie Bonnet on 09/09/2015.
//  Copyright © 2015 3IE. All rights reserved.
//

import Foundation
import Alamofire

class DataAccessMain
{
	private static var _apiBaseUrl: String? = nil
	
	static var apiBaseUrl: String {
		if (_apiBaseUrl == nil) {
			_apiBaseUrl = NSBundle.apiBaseUrl
		}
		return _apiBaseUrl!
    }
    
    static func initUrlRequestWithPath(path: String, method: Alamofire.Method) -> NSMutableURLRequest {
        let baseUrl = NSURL(string: self.apiBaseUrl)!
		let fullUrl = NSURL(string: path, relativeToURL: baseUrl)!
        let mutableURLRequest = NSMutableURLRequest(URL: fullUrl)
        mutableURLRequest.HTTPMethod = method.rawValue
		//mutableURLRequest.setValue("custom user token", forHTTPHeaderField: "custom token name")

        return mutableURLRequest
    }
}