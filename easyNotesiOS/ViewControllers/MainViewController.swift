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
import FirebaseDatabase
import FirebaseUI

class MainViewController: UIViewController, LoginButtonDelegate {

    var ref: DatabaseReference!
    let backgroundImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        // Add facebook login button
        let loginButton = LoginButton(readPermissions: [ .publicProfile, .email, .userFriends])
        loginButton.center = view.center
        loginButton.delegate = self
        view.addSubview(loginButton)
        
        //Set up Firebase database
        ref = Database.database().reference()
        
        //ref.child("users").childByAutoId().setValue("Chris")
        let artist = [
            "firstName": "Chris",
            "lastName": "Zhang",
            "email": "chris.zhang95@hotmail.com"
        ]
        
        ref.child("users").childByAutoId().setValue(artist)
        
        //Fetch data from firebase
        
        
        
        if AccessToken.current != nil {
            // User is logged in, use 'accessToken' here.
            print("Logged in ")
            OperationQueue.main.addOperation {
                [weak self] in
                self?.performSegue(withIdentifier: "menu", sender: self)
            }
        }
        
        
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
    
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        switch result {
            case .failed(let error):
            print(error)
            case .cancelled:
            print("User cancelled login.")
            case .success( _, _, _):
                //let connection = GraphRequestConnection()
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
}
