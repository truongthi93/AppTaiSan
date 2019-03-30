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
    var listAssetCount = 0
    @IBOutlet weak var AssetList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        darkMode = false
        setNeedsStatusBarAppearanceUpdate()
        
        self.AssetList.delegate = self
        self.AssetList.dataSource = self
        self.AssetList.register(UINib(nibName: "AssetTableViewCell", bundle: nil), forCellReuseIdentifier: "AssetTableViewCell")

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.AssetList.tableFooterView = UIView()
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
        listAssetCount = 10
        self.AssetList.reloadData()
    }
    
}

extension AssetSearchViewController: ConfirmAddAssetDelegate {
    func confirmAddAsset(isConfirmed : Bool, dataId: String){
        if isConfirmed{
            self.delegate?.addData(dataId: dataId)
            self.dismiss(animated: true, completion: nil)
        }
    }
}

extension AssetSearchViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listAssetCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AssetTableViewCell", for: indexPath) as! AssetTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ConfirmAssetInfoViewController(nibName: Constants.ConfirmAssetInfo.confirmAssetInfoViewController, bundle: nil)
        vc.assetId = ""
        vc.delegate  = self
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
