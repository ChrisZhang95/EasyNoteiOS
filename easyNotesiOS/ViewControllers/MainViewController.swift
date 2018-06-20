//
//  MainViewController.swift
//  easyNotesiOS
//
//  Created by Chris Zhang on 2018-06-13.
//  Copyright © 2018 Chris Zhang. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore

class MainViewController: UIViewController, LoginButtonDelegate {

    @IBOutlet weak var button: CustumButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Add facebook login button
        let loginButton = LoginButton(readPermissions: [ .publicProfile, .email, .userFriends])
        loginButton.center = view.center
        loginButton.delegate = self
        view.addSubview(loginButton)
        
        if let accessToken = AccessToken.current {
            // User is logged in, use 'accessToken' here.
            print("Logged in ")
            OperationQueue.main.addOperation {
                [weak self] in
                self?.performSegue(withIdentifier: "menu", sender: self)
            }
        }
    }
    
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        switch result {
            case .failed(let error):
            print(error)
            case .cancelled:
            print("User cancelled login.")
            case .success( _, _, _):
                let connection = GraphRequestConnection()
//                var request = GraphRequest.init(graphPath: "me")
//                request.parameters = ["fields":"email,first_name,last_name,picture.width(1000).height(1000),birthday,gender, friendlists"]
//
//                connection.add(request, completion: {
//                    (response, result) in
//                    print("Facebook graph Result:", result)
//                })
//                connection.start()
                self.performSegue(withIdentifier: "menu", sender: nil) //Segue has to be set to "Present Modally"
            
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        showToast(message: "Logged out")
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showToast(message : String) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
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
