//
//  FacebookInfoVC.swift
//  App
//
//  Created by Sabrine Elbahri on 03/10/2016.
//  Copyright © 2016 3IE. All rights reserved.
//

import UIKit
import socialNetwork
import SVProgressHUD

class FacebookInfoVC: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var ProfileImageView: UIImageView!
    
    //MARK: - Properties
    var firstName: String?
    var lastName: String?
    var email: String?
    var facebookId: String?
    var loginWithFacebook: LogInWithFacebook?

    //MARK: - Vc methods
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.dismiss()
        setupFacebookInformartion()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        cropping(imageView: ProfileImageView)

    }
    
    //MARK: - Setup view
    func setupFacebookInformartion() {
        firstNameTextField.text = firstName
        firstNameTextField.isEnabled = false
        lastNameTextField.text = lastName
        lastNameTextField.isEnabled = false
        emailTextField.text = email
        emailTextField.isEnabled = false
        
        self.loginWithFacebook?.getFacebookProfileImageUrlAsync(self.facebookId!) { image in
            self.ProfileImageView.image = image
            self.ProfileImageView.contentMode = .scaleAspectFit
        }
    }
    
    
    //MARK: - Treatment on image
    func cropping(imageView: UIImageView) {
        ProfileImageView.layer.borderWidth = 1
        ProfileImageView.layer.masksToBounds = false
        ProfileImageView.layer.borderColor = UIColor.white.cgColor
        ProfileImageView.layer.cornerRadius = ProfileImageView.frame.height / 2
        ProfileImageView.clipsToBounds = true
    }
    
}
