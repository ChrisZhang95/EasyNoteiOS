//
//  FirstViewController.swift
//  easyNotesiOS
//
//  Created by Chris Zhang on 2018-06-11.
//  Copyright © 2018 Chris Zhang. All rights reserved.
//

import UIKit
import Alamofire
class MenuViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    let backgroundImageView = UIImageView()
    
    @IBOutlet weak var imgView: UIImageView!
    
    let imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        //        let documentURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        //        print("URL: \(documentURL)")
        
        // Create UIImagePickerController on load up
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
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

    @IBAction func takeNewButtonClick(_ sender: Any) {
        
        //Camera mode
        imagePicker.sourceType = UIImagePickerControllerSourceType.camera
        //Present UIImagePickerController on UI
        self.present(imagePicker, animated: true){
            //After it is complete
        }
    }
    
    @IBAction func importButtonClick(_ sender: Any) {
        
        //Picture mode
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        //Present UIImagePickerController on UI
        self.present(imagePicker, animated: true){
            //After is is complete
        }
    }
    
    
    
    //Gets called after the image is picked
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        
        
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage{
            
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            if(imagePicker.sourceType == UIImagePickerControllerSourceType.camera){
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "takeNew") as! TakeNewNoteViewController
                newViewController.img = image
                self.navigationController?.pushViewController(newViewController, animated: true)
            }
            
            else{
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "import") as! ImportNoteViewController
                newViewController.img = image
                self.navigationController?.pushViewController(newViewController, animated: true)
            }
            
            
        }
            
        else if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            if(imagePicker.sourceType == UIImagePickerControllerSourceType.camera){
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "takeNew") as! TakeNewNoteViewController
                newViewController.img = image
                self.navigationController?.pushViewController(newViewController, animated: true)
            }
                
            else{
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "import") as! ImportNoteViewController
                newViewController.img = image
                self.navigationController?.pushViewController(newViewController, animated: true)
            }
        }
        else{
            //Error message
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
        _ = navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

