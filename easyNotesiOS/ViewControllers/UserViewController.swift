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
        try loginManager.logOut()
        
        let nextViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "userSignIn") as! UINavigationController
        self.present(nextViewController, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Display user name
        let defaults = UserDefaults.standard
        let firstName = defaults.object(forKey: "firstName") as! String
        let lastName = defaults.object(forKey: "lastName") as! String
        let name = firstName + " " + lastName
        userNameText.text = name
        
        //Display user profile
        let picture = defaults.object(forKey: "picture") as? Dictionary<String, AnyObject>
        let data = picture!["data"]! as? Dictionary<String, AnyObject>
        let url = data!["url"]!

        //picture!["data"]
//        let imageStr = picture!["url"] as String?
        let imageURL = URL(string: url as! String)
        if let data = try? Data(contentsOf: imageURL as! URL) {
            if let img = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image.image = img
                }
            }
        }
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
