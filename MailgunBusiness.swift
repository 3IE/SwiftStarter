//
//  MailgunBusiness.swift
//  App
//
//  Created by Benoit Verdier on 11/02/2016.
//  Copyright © 2016 3IE. All rights reserved.
//

import Foundation

class MailgunBusiness {

	static func SendMail(recipient: String, subject: String, content: String, completed:@escaping ((_ response: MailgunResponse?, _ error: Error?) -> Void)) -> Void {
		MailgunData.SendMail(recipient: recipient, subject: subject, content: content) { (response, error) in
			completed(response, error)
		}
	}
	
}
