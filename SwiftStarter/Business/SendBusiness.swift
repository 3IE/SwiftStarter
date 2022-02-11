//
//  SendBusiness.swift
//  iOS-Starter2019
//
//  Created by Sofiane Beors on 12/02/2019.
//  Copyright © 2019 3ie. All rights reserved.
//

import Foundation

class SendBusiness {
    static func sendData(data: String, dateSent: Date) async -> SendResponse? {
        return await SendData.sendData(data: data, dateSent: dateSent)
    }
}
