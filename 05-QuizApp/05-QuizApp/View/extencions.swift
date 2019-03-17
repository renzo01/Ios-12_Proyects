//
//  extencions.swift
//  04-Piano
//
//  Created by Walter gomez on 2/13/19.
//  Copyright © 2019 Walter gomez. All rights reserved.
//
import UIKit

@IBDesignable extension UIButton{
    @IBInspectable var borderWith: CGFloat{
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var cornerRadious: CGFloat{
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        set {
            guard let UIColor = newValue else {return}
            layer.borderColor = UIColor.cgColor
        }
        get {
            guard let color = layer.borderColor else {return nil}
            return UIColor(cgColor: color)
        }
    }
}
