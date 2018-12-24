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

    //Handles button click, function sends a http request to python machine learning backend server and retrieve a response
    @IBAction func httpRequestButtonClick(_ sender: Any) {
        //This is the ip address of the computer that flask server is running on. Inside python code, set app.run(host= '<ip_adress>') to the same address
//        Alamofire.request("http://192.168.0.19:5000/").responseJSON { response in
//            print("Request: \(String(describing: response.request))")   // original url request
//            print("Response: \(String(describing: response.response))") // http url response
//            print("Result: \(response.result)")                         // response serialization result
//
//            if let json = response.result.value {
//                print("JSON: \(json)") // serialized json response
//            }
//
//            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
//                print("Data: \(utf8Text)") // original server data as UTF8 string
//            }
//        }
        let manager = HTTPManager.init()
        manager.get()
    }
    
    func httpRequest(){
        
    }
    
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

