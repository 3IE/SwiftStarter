//
//  MailGunVC.swift
//  App
//
//  Created by Benoit Verdier on 11/02/2016.
//  Copyright © 2016 3IE. All rights reserved.
//

import UIKit
import SVProgressHUD

class MailgunVC: UIViewController, UITextFieldDelegate {

	@IBOutlet weak var recipientTextFieldOutlet: UITextField!
	@IBOutlet weak var subjectTextFieldOutlet: UITextField!
	@IBOutlet weak var contentTextFieldOutlet: UITextField!
		
    override func viewDidLoad() {
        super.viewDidLoad()
    }

	@IBAction func sendEmailAction(_ sender: AnyObject) {
		guard let recipient = self.recipientTextFieldOutlet.text, let subject = self.subjectTextFieldOutlet.text, let content = self.contentTextFieldOutlet.text else {
				SVProgressHUD.showError(withStatus: "Invalid data")
				return
		}
		SVProgressHUD.show(withStatus: "Sending in progress")
		MailgunBusiness.SendMail(recipient: recipient, subject: subject, content: content) { (response, error) in
			DispatchQueue.main.async(execute: {
				if (error == nil) {
					SVProgressHUD.showSuccess(withStatus: "Mail sent")
				}
				else {
					SVProgressHUD.showError(withStatus: "Failed to send email")
				}
			})
		}
	}
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}
	
}
