//
//  InventoryViewController.swift
//  InventoryAssert
//
//  Created by TruongThi on 12/16/18.
//  Copyright © 2018 Hospital. All rights reserved.
//

import UIKit

class InventoryViewController: BaseViewController {
    public var inventoryView: InventoryView! {
        guard isViewLoaded else { return nil }
        return view as? InventoryView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        darkMode = false
        setNeedsStatusBarAppearanceUpdate()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.title = Constants.Inventory.title
        let backButton = UIBarButtonItem(image: UIImage(named: "back.png"), style: .plain, target: self, action: #selector(back))
        self.navigationItem.leftBarButtonItem  = backButton
        self.inventoryView.tableView.tableFooterView = UIView()
    }
    
    @objc func back() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addNewInventory(_ sender: Any) {
        print("addNewInventory")
    }
    
    @IBAction func deleteInventory(_ sender: Any) {
        print("deleteInventory")
    }
    
    @IBAction func EditInventory(_ sender: Any) {
        print("EditInventory")
    }
}
