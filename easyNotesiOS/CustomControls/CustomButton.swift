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
