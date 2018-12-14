//
//  ColorExtension.swift
//  InventoryAssert
//
//  Created by Anh Tran on 2018/12/14.
//  Copyright © 2018 Hospital. All rights reserved.
//
import UIKit

extension UIColor {
    
    // Setup custom colours we can use throughout the app using hex values
    static let navigationBarColor = UIColor(hexFromString: "1581A9")
    static let navigationTextColor = UIColor.white//UIColor(red: 255, green: 0, blue: 0)
    
    convenience init(hexFromString:String, alpha:CGFloat = 1.0) {
        var cString:String = hexFromString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        var rgbValue:UInt32 = 10066329 //color #999999 if string has wrong format
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) == 6) {
            Scanner(string: cString).scanHexInt32(&rgbValue)
        }
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}

