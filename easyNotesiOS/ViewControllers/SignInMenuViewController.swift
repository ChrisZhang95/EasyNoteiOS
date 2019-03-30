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
import FirebaseAuth

class SignInMenuViewController: UIViewController, LoginButtonDelegate {
    let backgroundImageView = UIImageView()
    //Facebook login callback function
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        switch result {
        case .failed(let error):
            print(error)
        case .cancelled:
            print("\nUser cancelled login\n")
        case .success( _, _, _):
            guard let accessToken = AccessToken.current?.authenticationToken else {return}
            let credential = FacebookAuthProvider.credential(withAccessToken: accessToken)
            Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
                if let error = error  {
                    print("\n" + error.localizedDescription + "\n")
                    
                    return
                }
                
                //use graph api to retrieve user profile
                let connection = GraphRequestConnection()
                let parameter = ["fields": "email,  first_name, last_name, picture.type(large)"]
                connection.add(GraphRequest(graphPath: "/me", parameters: parameter)) { httpResponse, result in
                    switch result {
                    case .success(let response):
                        print("Graph Request Succeeded: \(response)")
                        
                        //Save user data into session
                        let email = response.dictionaryValue!["email"]
                        let picture = response.dictionaryValue!["picture"]
                        let firstName = response.dictionaryValue!["first_name"]
                        let lastName = response.dictionaryValue!["last_name"]
                        
                        let defaults = UserDefaults.standard
                        defaults.set(email, forKey:"email")
                        defaults.set(picture, forKey:"picture")
                        defaults.set(firstName, forKey:"firstName")
                        defaults.set(lastName, forKey:"lastName")
                        //default.synchronize()
                        
                    case .failed(let error):
                        print("Graph Request Failed: \(error)")
                    }
                }
                connection.start()
                
                print("\nFacebook user logged in\n")
                self.performSegue(withIdentifier: "menu", sender: nil) //Segue has to be set to "Present Modally"
            }
            
            
        }
    }
    
    //Facebook logout callback function
    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        print("\nFacebook user logged out\n")
    }
    

    @IBOutlet weak var emailSignUpButton: CustumButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        //Adding facebook button to the view
        let loginButton = LoginButton(readPermissions: [ .publicProfile, .email, .userFriends])
        loginButton.center = view.center
        loginButton.frame = CGRect(x: emailSignUpButton.frame.origin.x, y: emailSignUpButton.frame.origin.y + 80, width: emailSignUpButton.frame.width, height: emailSignUpButton.frame.height)
        loginButton.delegate = self
        view.addSubview(loginButton)
        
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
