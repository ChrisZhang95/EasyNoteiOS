//
//  CustomButton.swift
//  easyNotesiOS
//
//  Created by Chris Zhang on 2018-06-11.
//  Copyright © 2018 Chris Zhang. All rights reserved.
//

import UIKit

@IBDesignable
class CustumButton: UIButton {
    
    @IBInspectable var customButton:Bool = false {
        didSet {
            if customButton {
                layer.cornerRadius = frame.height / 4
            }
        }
    }
    
    override func prepareForInterfaceBuilder() {
        if customButton {
            layer.cornerRadius = frame.height / 2
        }
    }
}

@IBDesignable
class RoundButton: UIButton {
    
    @IBInspectable var roundButton:Bool = false {
        didSet {
            if roundButton {
                layer.cornerRadius = frame.height / 2
            }
        }
    }
    
    override func prepareForInterfaceBuilder() {
        if roundButton {
            layer.cornerRadius = frame.height / 2
        }
    }
}

@IBDesignable
class RoundImageView: UIImageView {
    
    @IBInspectable var roundImageView:Bool = false {
        didSet {
            if roundImageView{
                layer.cornerRadius = frame.width / 2
                clipsToBounds = true
            }
        }
    }
    
    override func prepareForInterfaceBuilder() {
        if roundImageView{
            layer.cornerRadius = frame.width / 2
            clipsToBounds = true
        }
    }
}
