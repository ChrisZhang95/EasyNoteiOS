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
    let backgroundImageView = UIImageView()
    var ref: DatabaseReference!
    
    @IBOutlet weak var UserName: UITextField!
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var Password: UITextField!
    
    //On sign up button click
    @IBAction func signUp(_ sender: Any) {
        
        //Retreive variables from textfields
        //guard let username = UserName.text else {return}
        guard let email = Email.text else {return}
        guard let password = Password.text else {return}
        
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if let error = error  {
                print("\n" + error.localizedDescription + "\n")
                return
            }
            print("\nUser signed up\n")
            self.performSegue(withIdentifier: "menu", sender: nil) //Segue has to be set to "Present Modally"
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set up Firebase database
        ref = Database.database().reference()
        setBackground()
    }
    
    func setBackground(){
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo:view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo:view.trailingAnchor).isActive = true
        backgroundImageView.image = UIImage(named: "background")
        view.sendSubview(toBack: backgroundImageView)
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
