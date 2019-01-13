//
//  ConfirmAssetInfoViewController.swift
//  InventoryAssert
//
//  Created by TruongThi on 12/22/18.
//  Copyright © 2018 Hospital. All rights reserved.
//

import UIKit

protocol ConfirmAddAssetDelegate: class {
    func confirmAddAsset(isConfirmed : Bool, dataId: String)
}

class ConfirmAssetInfoViewController: BaseViewController {
    weak var delegate: ConfirmAddAssetDelegate?
    var assetId = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        darkMode = false
        setNeedsStatusBarAppearanceUpdate()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.title = Constants.QASCanner.title
        let backButton = UIBarButtonItem(image: UIImage(named: "back.png"), style: .plain, target: self, action: #selector(back))
        self.navigationItem.leftBarButtonItem  = backButton
    }

    @objc func back() {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func confirm(_ sender: Any) {
        self.delegate?.confirmAddAsset(isConfirmed: true, dataId: self.assetId)
    }

    @IBAction func cancel(_ sender: Any) {
        self.delegate?.confirmAddAsset(isConfirmed: false, dataId: "")
    }
    
}
