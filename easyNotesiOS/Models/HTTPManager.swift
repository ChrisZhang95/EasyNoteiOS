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
    var converTxt: String = "1"
    var vc: UIViewController? = nil
    var indicator: UIActivityIndicatorView? = nil
    
    init() {
        //        self.server = "http://192.168.0.19:5000/"
        //        self.server = "http://100.65.197.192:5000/"
        let defaults = UserDefaults.standard
        let ipAddress = defaults.object(forKey: "ipAddress") as! String
        self.server = "http://" + ipAddress + ":5000/"
        print (self.server + "!!!!!!!!!")
    }
    
    //override IP address
    init(server: String) {
        self.server = server
    }
    
    //Upload image to the server
    func postImage(image: UIImage) {
        let imageData = UIImageJPEGRepresentation(image, 0.9)!
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(imageData, withName: "image", fileName: "image.jpeg", mimeType: "image/jpeg")
            },
            
            to: server+"image",
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        
                        if let json = response.result.value {
                            print("JSON: \(json)") // serialized json response
                        }
                        
                        if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                            
                            print("Data: \(utf8Text)") // original server data as UTF8 string
                            //Toast.show(message: utf8Text, controller: self.vc!)
                            
                            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                            let textViewController = storyBoard.instantiateViewController(withIdentifier: "textView") as! TextViewViewController
                            textViewController.text = utf8Text
                            self.indicator?.stopAnimating()
                            self.vc?.navigationController?.pushViewController(textViewController, animated: true)
                        }
                    }
                case .failure(let encodingError):
                    self.indicator?.stopAnimating()
                    print(encodingError)
                    Toast.show(message: "Error!", controller: self.vc!)
                }
            }
        )
    }
    func postFeedback(feedback: String){
        Alamofire.request(server+"feedback",method: .post, parameters: ["body" : feedback], encoding: JSONEncoding.default, headers: [:])
    }
    
    //Send a GET request to ther server
    func get(feedback: String){
        Alamofire.request(server + "/feedback/" + feedback).responseJSON { response in
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
