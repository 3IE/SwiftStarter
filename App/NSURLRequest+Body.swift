//
//  NSURLRequest+Body.swift
//  App
//
//  Created by Cédric Eugeni on 08/06/2015.
//  Copyright (c) 2015 3IE. All rights reserved.
//

/*import Foundation
import Alamofire

extension NSMutableURLRequest {

	fileprivate convenience init(fullUrl :URL, method: Alamofire.Method) {
		self(url: fullUrl)
		self.HTTPMethod = method.hashValue
		//Add here some other settings for your request
	}
	
	/**
	Create a new request based on the API base path
	
	- parameter apiPathRelativeToBase: relative path (that needs to be escaped) added to the apiBaseUrl
	- parameter method:                HTTP verb (get, post, delete, ...)
	
	- returns: a new request based on the API base path
	*/
	convenience init?(apiPathRelativeToBase path: String, method: Alamofire.Method) {
		guard let baseUrl = NSURL(string: Bundle.apiBaseUrl), let fullUrl = NSURL(string: path, relativeTo: baseUrl as URL) else {
			return nil
		}
		self.init(fullUrl: fullUrl as URL, method: method)
	}
	
	/**
	Create a new request
	
	- parameter apiPathAbsolute: absolute path (that needs to be escaped)
	- parameter method:          HTTP verb (get, post, delete, ...)
	
	- returns:
	*/
	convenience init?(apiPathAbsolute path: String, method: Alamofire.Method) {
		guard let fullUrl = NSURL(string: path) else {
			return nil
		}
		self.init(fullUrl: fullUrl as URL, method: method)
	}
	
} */
