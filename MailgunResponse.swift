//
//  MailgunResponse.swift
//  App
//
//  Created by Benoit Verdier on 11/02/2016.
//  Copyright © 2016 3IE. All rights reserved.
//

import Foundation
import ObjectMapper

struct MailgunResponse {
	var id: String?
	var message: String?
}

//MARK: ObjectMapper
extension MailgunResponse: Mappable {
	init?(_ map: Map) {
	}
	
	mutating func mapping(map: Map) {
		id <- map["id"]
		message <- map["message"]
	}
}
