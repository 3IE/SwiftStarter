//
//  RouterProtocol.swift
//  App
//
//  Created by Benoit Verdier on 10/02/2016.
//  Copyright © 2016 3IE. All rights reserved.
//

import Foundation
import Alamofire

protocol RouterProtocol {
	var method: Alamofire.HTTPMethod { get }
	var path: String { get }
}
