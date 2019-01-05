//
//  TextViewViewController.swift
//  easyNotesiOS
//
//  Created by Chris Zhang on 2019-01-05.
//  Copyright © 2019 Chris Zhang. All rights reserved.
//

import UIKit

class TextViewViewController: UIViewController {

    var text: String?
    
    @IBOutlet var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        textView.text = text
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonClick))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //On save button click
    @objc func saveButtonClick() {
        let file = "\(UUID().uuidString).txt"
        let contents = self.text
        
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = dir.appendingPathComponent(file)
        
        do {
            try contents?.write(to: fileURL, atomically: false, encoding: .utf8)
            Toast.show(message: "Saved", controller: self)
        }
        catch {
            Toast.show(message: error as! String, controller: self)
        }
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
