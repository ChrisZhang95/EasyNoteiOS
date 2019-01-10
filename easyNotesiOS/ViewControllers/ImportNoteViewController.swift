//
//  ImportNoteViewController.swift
//  easyNoteiOS
//
//  Created by Chris Zhang on 2018-06-10.
//  Copyright © 2018 Chris Zhang. All rights reserved.
//

import UIKit

class ImportNoteViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //Drawing
    var lastPoint = CGPoint.zero
    var red: CGFloat = 0.0
    var green: CGFloat = 0.0
    var blue: CGFloat = 0.0
    var brushWidth: CGFloat = 10.0
    var opacity: CGFloat = 1.0
    var swiped = false
    
    
    @IBOutlet weak var myImg: UIImageView!
    //@IBOutlet weak var tempImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Display share button on top right
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(shareButtonClick))
        
        // Create UIImagePickerController on load up
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        //image.allowsEditing = true
        
        //Present UIImagePickerController on UI
        self.present(image, animated: true){
            //After is is complete
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
        _ = navigationController?.popViewController(animated: true)
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
    
    //On share button click
    @objc func shareButtonClick() {
        //Share image
        let activityController = UIActivityViewController(activityItems: [myImg.image!], applicationActivities: nil)
        present(activityController, animated: true, completion: nil)
    }
    
    //Convert text by sending http request to server
    @IBAction func convertText(_ sender: Any) {
        let manager = HTTPManager.init()
        manager.vc = self
        manager.postImage(image: myImg.image!)
    }
//Drawing lines on image
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        swiped = false
//        if let touch = touches.first {
//            lastPoint = touch.location(in: self.view)
//        }
//    }
//
//    //Function that draws a line
//    func drawLineFrom(fromPoint: CGPoint, toPoint: CGPoint) {
//
//        // 1
//        UIGraphicsBeginImageContext(view.frame.size)
//        let context = UIGraphicsGetCurrentContext()
//        myImg.image?.draw(in: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
//
//        // 2
//        context?.move(to: CGPoint(x: fromPoint.x, y: fromPoint.y))
//        context?.addLine(to: CGPoint(x: toPoint.x, y: toPoint.y))
//
//        // 3
//        context!.setLineCap(.round)
//        context!.setLineWidth(brushWidth)
//        context!.setBlendMode(.normal)
//        context?.setStrokeColor(red:1, green: 1, blue: 1, alpha:1)
//
//        // 4
//        context!.strokePath()
//
//        // 5
//        myImg.image = UIGraphicsGetImageFromCurrentImageContext()
//        myImg.alpha = opacity
//        UIGraphicsEndImageContext()
//
//    }
//
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        // 6
//        swiped = true
//        if let touch = touches.first {
//            let currentPoint = touch.location(in: view)
//            drawLineFrom(fromPoint: lastPoint, toPoint: currentPoint)
//
//            // 7
//            lastPoint = currentPoint
//        }
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
