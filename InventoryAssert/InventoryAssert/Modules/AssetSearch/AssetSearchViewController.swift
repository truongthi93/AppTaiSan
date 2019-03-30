//
//  AssetSearchViewController.swift
//  InventoryAssert
//
//  Created by TruongThi on 3/30/19.
//  Copyright © 2019 Hospital. All rights reserved.
//

import UIKit

class AssetSearchViewController: BaseViewController {
    weak var delegate: AddQRCodeDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        darkMode = false
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = "Tìm tài sản"

        self.navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.barTintColor = UIColor.navigationBarColor
        navigationController?.navigationBar.isTranslucent = false
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.navigationTextColor]
        navigationController?.navigationBar.tintColor = UIColor.navigationTextColor
        
        
        self.title = Constants.QASCanner.title
        let backButton = UIBarButtonItem(image: UIImage(named: "back.png"), style: .plain, target: self, action: #selector(back))
        self.navigationItem.leftBarButtonItem  = backButton

    }
    @objc func back() {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func searchAsset(_ sender: Any) {
        let vc = ConfirmAssetInfoViewController(nibName: Constants.ConfirmAssetInfo.confirmAssetInfoViewController, bundle: nil)
        vc.assetId = ""
        vc.delegate  = self
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
}

extension AssetSearchViewController: ConfirmAddAssetDelegate {
    func confirmAddAsset(isConfirmed : Bool, dataId: String){
        if isConfirmed{
            self.dismiss(animated: true, completion: nil)
            self.delegate?.addData(dataId: dataId)
        }
    }
}
