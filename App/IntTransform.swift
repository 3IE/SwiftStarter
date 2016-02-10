//
//  StringToIntTransform.swift
//  App
//
//  Created by Benoit Verdier on 09/02/2016.
//  Copyright © 2016 3IE. All rights reserved.
//

import Foundation
import ObjectMapper

public class IntTransform: TransformType {
	public typealias Object = Int
	public typealias JSON = String
	
	public init() {}
	
	public func transformFromJSON(value: AnyObject?) -> Int? {
		if let strValue = value as? String {
			return Int(strValue)
		}
		return nil
	}
	
	public func transformToJSON(value: Int?) -> String? {
		return String(value)
	}
}