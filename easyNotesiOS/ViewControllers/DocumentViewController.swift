//
//  DocumentViewController.swift
//  FilesiOS
//
//  Created by Chris Zhang on 2018-09-05.
//  Copyright © 2018 Chris Zhang. All rights reserved.
//

import UIKit

class DocumentViewController: UIViewController {
    //let indicator = LoaderController()
    //var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    @IBOutlet weak var textView: UITextView!
    
    var document: UIDocument?
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.navigationItem.title = self.document?.localizedName;
        
        // Access the document
        document?.open(completionHandler: { (success) in
            if success {
                do{
                    //self.activityIndicator.stopAnimating()
                    // #4.2 - Display the document's file name.
                    //LoaderController.sharedInstance.showLoader()
                    self.navigationItem.title = self.document?.fileURL.lastPathComponent
                    self.textView.text = try String(contentsOf: (self.document?.fileURL)!)

                }
                catch{
                    
                }
            } else {
                //LoaderController.sharedInstance.removeLoader()
                // Make sure to handle the failed import appropriately, e.g., by presenting an error message to the user.
                //stop the indicator
                //self.activityIndicator.stopAnimating()
            }
        })
    }

    
    @IBAction func dismissDocumentViewController() {
        dismiss(animated: true) {
            self.document?.close(completionHandler: nil)
        }
    }
}
