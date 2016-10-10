//
//  StringToIntTransform.swift
//  App
//
//  Created by Benoit Verdier on 09/02/2016.
//  Copyright © 2016 3IE. All rights reserved.
//

import Foundation
import ObjectMapper

open class IntTransform: TransformType {

	public typealias Object = Int
	public typealias JSON = String
	
	public init() {}
	
	open func transformFromJSON(_ value: Any?) -> Int? {
		if let strValue = value as? String {
			return Int(strValue)
		}
		return nil
	}
	
	open func transformToJSON(_ value: Int?) -> String? {
		return String(describing: value)
	}
}
