//
//  NSURLRequest+Body.swift
//  App
//
//  Created by Cédric Eugeni on 08/06/2015.
//  Copyright (c) 2015 3IE. All rights reserved.
//

import Foundation
import Alamofire

extension NSMutableURLRequest {
	
	/**
	Create a new request based on the API base path
	
	- parameter apiPathRelativeToBase: this path (that needs to be escaped) is added to the apiBaseUrl
	- parameter method:                HTTP verb (get, post, delete, ...)
	
	- returns: a new request based on the API base path
	*/
	convenience init?(apiPathRelativeToBase path: String, method: Alamofire.Method) {
		let baseUrl = NSURL(string: NSBundle.apiBaseUrl)!
		let fullUrl = NSURL(string: path, relativeToURL: baseUrl)!
		self.init(URL: fullUrl)
		self.HTTPMethod = method.rawValue
		//Add here some other settings for your request
	}
	
}