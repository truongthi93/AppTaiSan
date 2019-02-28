//
//  AddNoteManualForAssetViewController.swift
//  InventoryAssert
//
//  Created by TruongThi on 2/24/19.
//  Copyright © 2019 Hospital. All rights reserved.
//

import UIKit

class AddNoteManualForAssetViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        darkMode = false
        setNeedsStatusBarAppearanceUpdate()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
        self.title = Constants.AddNote.title
        let backButton = UIBarButtonItem(image: UIImage(named: "back.png"), style: .plain, target: self, action: #selector(back))
        self.navigationItem.leftBarButtonItem  = backButton
    }
    
    @objc func back() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
