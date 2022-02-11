//
//  SendVC.swift
//  iOS-Starter2019
//
//  Created by Sofiane Beors on 12/02/2019.
//  Copyright © 2019 3ie. All rights reserved.
//

import UIKit

class SendVC: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var responseTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func sendDidTapped(_ sender: Any) {
        guard self.textField.text != "" else { return }
        
        Task {
            let response = await SendBusiness.sendData(data: self.textField.text!, dateSent: Date())
            guard let response = response else { fatalError("no response") }
            
            DispatchQueue.main.async {
                self.responseTextView.text += "At: \(String(describing: response.dateSent!)) - Data: \(String(describing: response.dataReturned!))\n"
            }
        }
    }
}
