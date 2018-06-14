//
//  MainViewController.swift
//  easyNotesiOS
//
//  Created by Chris Zhang on 2018-06-13.
//  Copyright © 2018 Chris Zhang. All rights reserved.
//

import UIKit
import FacebookLogin

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Add facebook login button
        let loginButton = LoginButton(readPermissions: [ .publicProfile ])
        loginButton.center = view.center
        
        view.addSubview(loginButton)
        
//        if let accessToken = AccessToken.current {
//            // User is logged in, use 'accessToken' here.
//        }
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
