//
//  BaseViewController.swift
//  InventoryAssert
//
//  Created by TruongThi on 12/16/18.
//  Copyright © 2018 Hospital. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    var darkMode = true

    override func viewDidLoad() {
        super.viewDidLoad()
        setNeedsStatusBarAppearanceUpdate()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return darkMode ? .default : .lightContent
    }

}
