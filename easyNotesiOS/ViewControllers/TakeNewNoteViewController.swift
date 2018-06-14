//
//  TakeNewNoteViewController.swift
//  easyNotesiOS
//
//  Created by Chris Zhang on 2018-06-14.
//  Copyright © 2018 Chris Zhang. All rights reserved.
//

import UIKit

class TakeNewNoteViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var myImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create UIImagePickerController on load up
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.camera
        image.allowsEditing = true

        //Present UIImagePickerController on UI
        self.present(image, animated: true){
            //After is is complete
        }
    }
    
    //Gets called after the image is picked
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            myImg.image = image
        }
        else{
            //Error message
        }

        self.dismiss(animated: true, completion: nil)
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
