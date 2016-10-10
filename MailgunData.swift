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
	case sendMail([String: AnyObject])
}

//MARK: RouterProtocol
extension Router: RouterProtocol {
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .sendMail:
            return .post
        }
    }

	var path: String {
		switch self {
		case .sendMail:
			return "https://api.mailgun.net/v3/sandbox72c4329542d34f668085a9f3d71203e9.mailgun.org/messages"
		}
	}
}

//MARK: URLRequestConvertible
extension Router: URLRequestConvertible {
    /// Returns a URL request or throws if an `Error` was encountered.
    ///
    /// - throws: An `Error` if the underlying `URLRequest` is `nil`.
    ///
    /// - returns: A URL request.
    public func asURLRequest() throws -> URLRequest {
        
        var urlRequest = URLRequest(url: URL(string: self.path)!)
        urlRequest.httpMethod = self.method.rawValue

        switch self {
        case .sendMail(let body):
            return try Alamofire.URLEncoding.default.encode(urlRequest, with: body)
        }
    }
}

//MARK: - WeatherData
class MailgunData {
	
	static func SendMail(recipient: String, subject: String, content: String, completed:@escaping ((_ response: MailgunResponse?, _ error: Error?) -> Void)) -> Void {
		precondition(kMailgunSender.characters.count > 0 && kMailgunApiKey.characters.count > 0, "You need to provide the mailgun info")
		let body: [String: AnyObject] = [
			"from": kMailgunSender as AnyObject,
			"to": recipient as AnyObject,
			"subject": subject as AnyObject,
			"text": content as AnyObject]		
		Alamofire.request(Router.sendMail(body))
			.authenticate(user: "api", password: kMailgunApiKey)
			.validate()
			.responseObject { (alamoResponse: DataResponse<MailgunResponse>) in
				completed(alamoResponse.result.value, alamoResponse.result.error)
		}
	}
}
