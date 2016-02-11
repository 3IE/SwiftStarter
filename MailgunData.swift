//
//  MailgunData.swift
//  App
//
//  Created by Benoit Verdier on 11/02/2016.
//  Copyright © 2016 3IE. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

private let kMailgunSender = "" //TODO: fill this with your info
private let kMailgunApiKey = "" //TODO: fill this with your info

//MARK: Router class
private enum Router {
	case SendMail([String: AnyObject])
}

//MARK: RouterProtocol
extension Router: RouterProtocol {
	
	var method: Alamofire.Method {
		switch self {
		case .SendMail:
			return .POST
		}
	}
	
	var path: String {
		switch self {
		case .SendMail:
			return "https://api.mailgun.net/v3/sandbox72c4329542d34f668085a9f3d71203e9.mailgun.org/messages"
		}
	}
}

//MARK: URLRequestConvertible
extension Router: URLRequestConvertible {
	var URLRequest: NSMutableURLRequest {
		guard let mutableURLRequest = NSMutableURLRequest(apiPathAbsolute: self.path, method: self.method) else {
			return NSMutableURLRequest()
		}
		switch self {
		case .SendMail(let body):
			return Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: body).0
		}
	}
}

//MARK: - WeatherData
class MailgunData {
	
	static func SendMail(recipient recipient: String, subject: String, content: String, completed:((response: MailgunResponse?, error: AppError?) -> Void)) -> Void {
		precondition(kMailgunSender.characters.count > 0 && kMailgunApiKey.characters.count > 0, "You need to provide the mailgun info")
		let body: [String: AnyObject] = [
			"from": kMailgunSender,
			"to": recipient,
			"subject": subject,
			"text": content]		
		Alamofire.request(Router.SendMail(body))
			.authenticate(user: "api", password: kMailgunApiKey)
			.validate()
			.responseObject { (alamoResponse: Response<MailgunResponse, NSError>) in
				completed(response: alamoResponse.result.value, error: AppError(response: alamoResponse))
		}
	}
}
