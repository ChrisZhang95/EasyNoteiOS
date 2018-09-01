//
//  HTTPManager.swift
//  easyNotesiOS
//
//  Created by Chris Zhang on 2018-08-11.
//  Copyright © 2018 Chris Zhang. All rights reserved.
//

import UIKit
import Alamofire

class HTTPManager {
    
    /*  server address where the request is sent to
    This is the ip address of the computer that flask server is running on.
    Inside python code, set app.run(host= '<ip_adress>') to the same address, excluding the port number*/
    var server: String
    
    init() {
        self.server = "http://192.168.0.13:5000/image"
    }
    
    //override IP address
    init(server: String) {
        self.server = server
    }
    
    //Upload image to the server
    func postImage(image: UIImage){
        let imageData = UIImageJPEGRepresentation(image, 0.9)!
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(imageData, withName: "image", fileName: "image.jpeg", mimeType: "image/jpeg")
        },
            to: server,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        print("Request: \(String(describing: response.request))")   // original url request
                        print("Response: \(String(describing: response.response))") // http url response
                        print("Result: \(response.result)")                         // response serialization result
                        
                        if let json = response.result.value {
                            print("JSON: \(json)") // serialized json response
                        }
                        
                        if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                            print("Data: \(utf8Text)") // original server data as UTF8 string
                        }
                    }
                case .failure(let encodingError):
                    print(encodingError)
                }
        }
        )
    }
    
    
    
    //Send a GET request to ther server
    func get(){
        Alamofire.request(server).responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }
        }
    }
}
