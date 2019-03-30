//
//  TakeNewNoteViewController.swift
//  easyNotesiOS
//
//  Created by Chris Zhang on 2018-06-14.
//  Copyright © 2018 Chris Zhang. All rights reserved.
//

import UIKit

class TakeNewNoteViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    var img:UIImage? = nil
    @IBOutlet weak var myImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Display share button on top right
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(shareButtonClick))
        
        myImg.image = img
//        // Create UIImagePickerController on load up
//        let image = UIImagePickerController()
//        image.delegate = self
//        image.sourceType = UIImagePickerControllerSourceType.camera
//        image.allowsEditing = true
//
//        //Present UIImagePickerController on UI
//        self.present(image, animated: true){
//            //After it is complete
//        }
    }
    
//    //Gets called after the image is picked
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
//            myImg.image = image
//            //sharedImg = image
//        }
//        else{
//            //Error message
//        }
//
//        self.dismiss(animated: true, completion: nil)
//    }
//    
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        self.dismiss(animated: true, completion: nil)
//        _ = navigationController?.popViewController(animated: true)
//    }

    @IBAction func convertText(_ sender: Any) {
        let manager = HTTPManager.init()
        manager.vc = self
        manager.postImage(image: myImg.image!)
        LoaderController.sharedInstance.showLoader()
        activityIndicator.center = self.view.center
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        manager.indicator = activityIndicator
    }
    
    //On share button click
    @objc func shareButtonClick() {
        //activityIndicator.stopAnimating()
        //Share image
        let activityController = UIActivityViewController(activityItems: [myImg.image!], applicationActivities: nil)
        present(activityController, animated: true, completion: nil)
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
