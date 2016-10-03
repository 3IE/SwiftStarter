//
//  FacebookInfoVC.swift
//  App
//
//  Created by Sabrine Elbahri on 03/10/2016.
//  Copyright © 2016 3IE. All rights reserved.
//

import UIKit
import socialNetwork

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
    var logOutWithFacebook: LogOutWithFacebook = LogOutWithFacebook.init()
    
    //MARK: - Vc methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - LogOut
    @IBAction func LogOut(_ sender: AnyObject) {
        logOutWithFacebook.logOut()
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let controller: FacebookConnectVC = storyboard.instantiateViewController(withIdentifier: "FacebookConnectVC") as! FacebookConnectVC
        self.present(controller, animated: true, completion: nil)
    }
}
