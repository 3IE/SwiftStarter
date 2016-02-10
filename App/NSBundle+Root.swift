//
//  NSURL+Root.swift
//  App
//
//  Created by Cédric Eugeni on 08/06/2015.
//  Copyright (c) 2015 3IE. All rights reserved.
//

import Foundation

extension NSBundle {
	static var apiBaseUrl: String {
        return NSBundle.mainBundle().objectForInfoDictionaryKey("kAPIBaseUrl") as? String ?? ""
    }
    
    //Add methods here in order to get the other endpoints
}