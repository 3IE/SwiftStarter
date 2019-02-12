//
// RouterProtocol.swift
// iOS-Starter2019
//
// Created by Sofiane Beors on 11/02/2019.
//Copyright © 2019 3ie. All rights reserved.
//

import Foundation
import Alamofire

protocol RouterProtocol {
    var method: Alamofire.HTTPMethod { get }
    var path: String { get }
}
