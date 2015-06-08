//
//  NSURL+Root.swift
//  App
//
//  Created by Cédric Eugeni on 08/06/2015.
//  Copyright (c) 2015 Cédric Eugeni. All rights reserved.
//

import Foundation

public extension NSURL {
    public static func getRootEndpoint() -> String {
        return NSBundle.mainBundle().objectForInfoDictionaryKey("kRootEndpoint") as? String ?? ""
    }
    
    //Add methods here in order to get the other endpoints
}