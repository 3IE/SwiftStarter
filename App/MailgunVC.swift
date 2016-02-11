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

	@IBAction func sendEmailAction(sender: AnyObject) {
		guard let recipient = self.recipientTextFieldOutlet.text, let subject = self.subjectTextFieldOutlet.text, let content = self.contentTextFieldOutlet.text else {
				SVProgressHUD.showErrorWithStatus("Invalid data")
				return
		}
		SVProgressHUD.showWithStatus("Sending in progress")
		MailgunBusiness.SendMail(recipient: recipient, subject: subject, content: content) { (response, error) in
			dispatch_async(dispatch_get_main_queue(), {
				if (error == nil) {
					SVProgressHUD.showSuccessWithStatus("Mail sent")
				}
				else {
					SVProgressHUD.showErrorWithStatus("Failed to send email")
				}
			})
		}
	}
	
	func textFieldShouldReturn(textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}
	
}
