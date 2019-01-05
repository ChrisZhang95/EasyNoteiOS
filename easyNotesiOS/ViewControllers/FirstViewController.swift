//
//  FirstViewController.swift
//  easyNotesiOS
//
//  Created by Chris Zhang on 2018-06-11.
//  Copyright © 2018 Chris Zhang. All rights reserved.
//

import UIKit
import Alamofire
class FirstViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        let documentURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        print("URL: \(documentURL)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

