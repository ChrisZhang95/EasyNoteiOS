//
//  MainPageViewController.swift
//  easyNotesiOS
//
//  Created by Chris Zhang on 2018-06-23.
//  Copyright © 2018 Chris Zhang. All rights reserved.
//

import UIKit
import FirebaseAuth

class MainPageViewController: UIViewController {
    let backgroundImageView = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
//    self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        if Auth.auth().currentUser != nil {
            let defaults = UserDefaults.standard
            if(defaults.object(forKey: "ipAddress") == nil){
                defaults.set("", forKey:"ipAddress")
            }
            performSegue(withIdentifier: "menu", sender: self)
        } else {
            // No user is signed in, do nothing
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
