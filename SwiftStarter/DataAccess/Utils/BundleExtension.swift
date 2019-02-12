//
//  BundleExtension.swift
//  iOS-Starter2019
//
//  Created by Sofiane Beors on 11/02/2019.
//  Copyright © 2019 3ie. All rights reserved.
//

import Foundation

extension Bundle {
    
    fileprivate static var _apiBaseUrl: String? = nil
    fileprivate static var _secondApiBaseUrl: String? = nil
    fileprivate static var _apiKey: String? = nil

    /// returns the API base url that is shared by your web services
    static var apiBaseUrl: String {
        if (_apiBaseUrl == nil) {
            _apiBaseUrl = Bundle.main.object(forInfoDictionaryKey: "kAPIBaseUrl") as? String ?? ""
        }
        return _apiBaseUrl!
    }
    
    /// returns the API base url that is shared by your web services
    static var secondApiBaseUrl: String {
        if (_secondApiBaseUrl == nil) {
            _secondApiBaseUrl = Bundle.main.object(forInfoDictionaryKey: "kSecondAPIBaseUrl") as? String ?? ""
        }
        return _secondApiBaseUrl!
    }
    
    /// returns the API key shared by your web services
    static var apiKey: String {
        if (_apiKey == nil) {
            _apiKey = Bundle.main.object(forInfoDictionaryKey: "kAPIKey") as? String ?? ""
        }
        return _apiKey!
    }
}
