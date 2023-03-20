//
//  RegisterViewController.swift
//  Community Events
//
//  Created by Blake Ezechi on 14/03/2023.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.isHidden = true
    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
        
        if let email = emailTextfield.text, let password = passwordTextfield.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    self.errorLabel.isHidden = false
                    self.errorLabel.text = e.localizedDescription
                } else {
                    //Navigate to the chatViewController
                    self.performSegue(withIdentifier: Constants.registerSegue, sender: self)
                }
            } //with this optional binding, it means you can't have a nil email and password to create a user. which is what is required
        }
    }
    
}
