//
//  EmailSignInViewController.swift
//  easyNotesiOS
//
//  Created by Chris Zhang on 2018-06-23.
//  Copyright © 2018 Chris Zhang. All rights reserved.
//

import UIKit
import FirebaseAuth

class EmailSignInViewController: UIViewController {

    let backgroundImageView = UIImageView()
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var Password: UITextField!
    
    //On sign in button click
    @IBAction func signIn(_ sender: Any) {
        guard let email = Email.text else {return}
        guard let password = Password.text else {return}
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error == nil && user != nil{
                print("\nUser logged in\n")
                self.performSegue(withIdentifier: "menu", sender: nil) //Segue has to be set to "Present Modally"
            }
            else{
                print("\nFailed to log in\n")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
