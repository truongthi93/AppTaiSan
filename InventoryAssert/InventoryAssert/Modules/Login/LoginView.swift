//
//  LoginView.swift
//  InventoryAssert
//
//  Created by TruongThi on 11/3/18.
//  Copyright © 2018 Hospital. All rights reserved.
//

import UIKit

class LoginView: UIView {
    @IBOutlet weak var tfUserName: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
