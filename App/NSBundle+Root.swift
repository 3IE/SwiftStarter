//
//  NSURL+Root.swift
//  App
//
//  Created by Cédric Eugeni on 08/06/2015.
//  Copyright (c) 2015 3IE. All rights reserved.
//

import Foundation

extension Bundle {
	
	fileprivate static var _apiBaseUrl: String? = nil
	
	/// returns the API base url that is shared by your web services 
	static var apiBaseUrl: String {
		if (_apiBaseUrl == nil) {
			_apiBaseUrl = Bundle.main.object(forInfoDictionaryKey: "kAPIBaseUrl") as? String ?? ""
		}
		return _apiBaseUrl!
	}
	
	//Add methods here in order to get the other endpoints
}
