//
//  SignInMenuViewController.swift
//  easyNotesiOS
//
//  Created by Chris Zhang on 2018-06-23.
//  Copyright © 2018 Chris Zhang. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore

class SignInMenuViewController: UIViewController, LoginButtonDelegate {
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        switch result {
        case .failed(let error):
            print(error)
        case .cancelled:
            print("\nUser cancelled login\n")
        case .success( _, _, _):
            print("\nFacebook user logged out\n")
            self.performSegue(withIdentifier: "menu", sender: nil) //Segue has to be set to "Present Modally"
            
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        print("\nFacebook user logged out\n")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let loginButton = LoginButton(readPermissions: [ .publicProfile, .email, .userFriends])
        loginButton.center = view.center
        loginButton.delegate = self
        view.addSubview(loginButton)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
