//
//  SecondViewController.swift
//  easyNotesiOS
//
//  Created by Chris Zhang on 2018-06-11.
//  Copyright © 2018 Chris Zhang. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if (AccessToken.current != nil) {
            // User is logged in, use 'accessToken' here.
            print("Logged in!!!!! ")
            
            let params = ["fields" : "email, name"]
            let graphRequest = GraphRequest(graphPath: "me", parameters: params)
            graphRequest.start {
                (urlResponse, requestResult) in
                
                switch requestResult {
                case .failed(let error):
                    print("error in graph request:", error)
                    break
                case .success(let graphResponse):
                    if let responseDictionary = graphResponse.dictionaryValue {
                        print(responseDictionary)
                        
                        print(responseDictionary["name"]!)
                        print(responseDictionary["email"]!)
                    }
                }
            }
            
        }
    }

    func fetchProfile(){
        let parameters = ["fields": "email, first_name, last_name, picture.type(large)" ]
        
    }
    
    struct MyProfileRequest: GraphRequestProtocol {
        struct Response: GraphResponseProtocol {
            init(rawResponse: Any?) {
                // Decode JSON from rawResponse into other properties here.
            }
        }
        
        var graphPath = "/me"
        var parameters: [String : Any]? = ["fields": "id, name"]
        var accessToken = AccessToken.current
        var httpMethod: GraphRequestHTTPMethod = .GET
        var apiVersion: GraphAPIVersion = .defaultVersion
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

