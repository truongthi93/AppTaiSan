//
//  InventoryReviewViewController.swift
//  InventoryAssert
//
//  Created by TruongThi on 12/16/18.
//  Copyright © 2018 Hospital. All rights reserved.
//

import UIKit

class InventoryReviewViewController: BaseViewController {
    public var inventoryReviewView: InventoryReviewView! {
        guard isViewLoaded else { return nil }
        return view as? InventoryReviewView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        darkMode = false
        setNeedsStatusBarAppearanceUpdate()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.title = Constants.InventoryReview.title
        let backButton = UIBarButtonItem(image: UIImage(named: "back.png"), style: .plain, target: self, action: #selector(back))
        self.navigationItem.leftBarButtonItem  = backButton
        self.inventoryReviewView.tableView.tableFooterView = UIView()
    }
    
    @objc func back() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addNewInventoryReview(_ sender: Any) {
        print("addNewInventoryReview")
        let vc = AddReviewViewController(nibName: "AddReviewViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    @IBAction func deleteInventoryReview(_ sender: Any) {
        print("deleteInventoryReview")
    }
    
    @IBAction func EditInventoryReview(_ sender: Any) {
        let vc = AddReviewViewController(nibName: "AddReviewViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)

        print("EditInventoryReview")
    }
}
