//
//  EmailSignUpViewController.swift
//  easyNotesiOS
//
//  Created by Chris Zhang on 2018-06-23.
//  Copyright © 2018 Chris Zhang. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore
import FirebaseDatabase
import FirebaseUI
import FirebaseAuth

class EmailSignUpViewController: UIViewController {

    var ref: DatabaseReference!
    
    @IBOutlet weak var UserName: UITextField!
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var Password: UITextField!
    
    @IBAction func signUp(_ sender: Any) {
        
        //Retreive variables from textfields
        guard let username = UserName.text else {return}
        guard let email = Email.text else {return}
        guard let password = Password.text else {return}
        
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            print("\nUser signed up\n")
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        //Set up Firebase database
        ref = Database.database().reference()
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
