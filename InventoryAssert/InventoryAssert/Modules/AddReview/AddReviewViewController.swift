//
//  AddReviewViewController.swift
//  InventoryAssert
//
//  Created by TruongThi on 12/16/18.
//  Copyright © 2018 Hospital. All rights reserved.
//

import UIKit

class AddReviewViewController: BaseViewController {

    public var addReviewView: AddReviewView! {
        guard isViewLoaded else { return nil }
        return view as? AddReviewView
    }
    var isAddNewReview = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        darkMode = false
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = Constants.AddReview.title
        let backButton = UIBarButtonItem(image: UIImage(named: "back.png"), style: .plain, target: self, action: #selector(back))
        self.navigationItem.leftBarButtonItem  = backButton
    }
    
    @objc func back() {
        self.navigationController?.popViewController(animated: true)
    }
}
