//
//  UserViewController.swift
//  easyNotesiOS
//
//  Created by Chris Zhang on 2018-06-14.
//  Copyright © 2018 Chris Zhang. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore
import FirebaseAuth
class UserViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    
    let backgroundImageView = UIImageView()
    //imageview for user profile
    @IBOutlet weak var image: UIImageView!
    //Label for user name
    @IBOutlet weak var userNameText: UILabel!
    //On sign out button click
    @IBAction func signOut(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            print("\nUser signed out\n")
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        let loginManager = LoginManager()
        loginManager.logOut()
        defaults.set(nil, forKey:"firstName")
        defaults.set(nil, forKey:"lastName")
        
        let nextViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "userSignIn") as! UINavigationController
        
        
        self.present(nextViewController, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Display network button on top right
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Network", style: .plain, target: self, action: #selector(networkButtonClick))
        
        //Display user name
        

        let firstName = defaults.object(forKey: "firstName") as? String
        let lastName = defaults.object(forKey: "lastName") as? String
        
        if(firstName != nil && lastName != nil){
            let name = firstName! + " " + lastName!
            userNameText.text = name
        }
        
        
        //Display user profile
        let picture = defaults.object(forKey: "picture") as? Dictionary<String, AnyObject>
        if(picture != nil){
            let data = picture!["data"]! as? Dictionary<String, AnyObject>
            let url = data!["url"]!
            
            //picture!["data"]
            //        let imageStr = picture!["url"] as String?
            let imageURL = URL(string: url as! String)
            if let data = try? Data(contentsOf: (imageURL as URL?)!) {
                if let img = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.image.image = img
                    }
                }
            }
        }
        
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

    //On network button click
    @objc func networkButtonClick() {
        
        let defaults = UserDefaults.standard
        //Share image
        let alertController = UIAlertController(title: "Network Configuration", message: "", preferredStyle: .alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            let ipAddress = (defaults.object(forKey: "ipAddress") as! String)
            textField.keyboardType = .decimalPad
            textField.placeholder = ipAddress
        }
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: { alert -> Void in
            let firstTextField = alertController.textFields![0] as UITextField
            
            defaults.set(firstTextField.text, forKey:"ipAddress")
            print("http://" + firstTextField.text! + ":5000/")
            
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: { (action : UIAlertAction!) -> Void in })
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
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
