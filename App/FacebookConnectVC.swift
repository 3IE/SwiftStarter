//
//  FacebookConnectVC.swift
//  App
//
//  Created by Sabrine Elbahri on 03/10/2016.
//  Copyright © 2016 3IE. All rights reserved.
//

import UIKit
import socialNetwork

class FacebookConnectVC: UIViewController {

    //MARK: - Properties
    var facebookId: String?
    var firstName: String?
    var lastName: String?
    var email: String?
    var profileImageView: UIImageView?
    var loginWithFacebook: LogInWithFacebook = LogInWithFacebook.init()
    
    //MARK: - VC methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Login
    @IBAction func LogIn(_ sender: AnyObject) {
        loginWithFacebook.login(self) { userInfo, cancelled, failed, isDeclinedPermissions in
            if userInfo != nil {
                self.facebookId  = self.loginWithFacebook.getFacebookIdFromUserInfoInTheCompletionHandlerFromLoginFunction(userInfo!)
                self.firstName = self.loginWithFacebook.getUserFirstNameFromUserInfoInTheCompletionHandlerFromLoginFunction(userInfo!)
                self.lastName = self.loginWithFacebook.getUserLastNameFromUserInfoInTheCompletionHandlerFromLoginFunction(userInfo!)
                self.email = self.loginWithFacebook.getUserEmailFromUserInfoInTheCompletionHandlerFromLoginFunction(userInfo!)
                
                self.loginWithFacebook.getFacebookProfileImageUrlAsync(self.facebookId) { image in
                    self.profileImageView?.image = image
                    self.profileImageView?.contentMode = .scaleAspectFit
                    self.cropping(imageView: self.profileImageView!)
                    
                    self.performSegue(withIdentifier: "PushFacebookInfo", sender: nil)
                }
            }
            
        }
    }
    
    //MARK: - Treatment on image
    func cropping(imageView: UIImageView) {
        imageView.layer.borderWidth = 1
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.clipsToBounds = true
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
            controller.ProfileImageView = profileImageView
        }
    }
}
