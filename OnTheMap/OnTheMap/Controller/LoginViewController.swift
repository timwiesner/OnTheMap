//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by Tim Wiesner on 3/18/19.
//  Copyright © 2019 Tim Wiesner. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    class func login(username: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
//        var request = URLRequest(url: Endpoints.)
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "completeLogin", sender: nil)
    }
}

