//
// SendDataResponse.swift
// iOS-Starter2019
//
// Created by Sofiane Beors on 12/02/2019.
//Copyright © 2019 3ie. All rights reserved.
//

import Foundation
import ObjectMapper

struct SendResponse {
    var dataReturned: String?
    var dateSent: String?
}

extension SendResponse: Mappable {
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        dataReturned <- map["data.data"]
        dateSent <- map["data.dateSent"]
    }
}
