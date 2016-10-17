//
//  FacebookConnectVC.swift
//  App
//
//  Created by Sabrine Elbahri on 03/10/2016.
//  Copyright © 2016 3IE. All rights reserved.
//

import UIKit
import socialNetwork
import SVProgressHUD

class FacebookConnectVC: UIViewController {

    //MARK: - Properties
    var firstName: String?
    var lastName: String?
    var email: String?
    var facebookId: String?
    var logInWithFacebook: LogInWithFacebook = LogInWithFacebook.init()
    var logOutWithFacebook: LogOutWithFacebook = LogOutWithFacebook.init()
    
    //MARK: - VC methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        logOutWithFacebook.logOut()
    }
    
    //MARK: - Login
    @IBAction func LogIn(_ sender: AnyObject) {
        logInWithFacebook.login(self) { userInfo, cancelled, failed, isDeclinedPermissions in
            if userInfo != nil {
                SVProgressHUD.show(withStatus: "Chargement")

                self.facebookId  = self.logInWithFacebook.getFacebookIdFromUserInfoInTheCompletionHandlerFromLoginFunction(userInfo!)
                self.firstName = self.logInWithFacebook.getUserFirstNameFromUserInfoInTheCompletionHandlerFromLoginFunction(userInfo!)
                self.lastName = self.logInWithFacebook.getUserLastNameFromUserInfoInTheCompletionHandlerFromLoginFunction(userInfo!)
                self.email = self.logInWithFacebook.getUserEmailFromUserInfoInTheCompletionHandlerFromLoginFunction(userInfo!)
                
                self.performSegue(withIdentifier: "PushFacebookInfo", sender: nil)

            }
            
        }
    }
    
    //MARK: - TextFieldKeyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PushFacebookInfo" {
            let controller: FacebookInfoVC = segue.destination as! FacebookInfoVC
            
            controller.firstName = firstName
            controller.lastName = lastName
            controller.email = email
            controller.facebookId = facebookId!
            controller.loginWithFacebook = logInWithFacebook
        }
    }
}
