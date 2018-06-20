//
//  UserViewController.swift
//  easyNotesiOS
//
//  Created by Chris Zhang on 2018-06-14.
//  Copyright © 2018 Chris Zhang. All rights reserved.
//

import UIKit
import FacebookLogin

class UserViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Add facebook login button
        let loginButton = LoginButton(readPermissions: [ .publicProfile ])
        loginButton.center = view.center
        
        view.addSubview(loginButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        switch result {
        case .failed(let error):
            print(error)
        case .cancelled:
            print("User cancelled login.")
        case .success( _, _, _):
            print("Logged in")
            
        }
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
