//
//  AssetListInWareHouseViewController.swift
//  InventoryAssert
//
//  Created by TruongThi on 12/22/18.
//  Copyright © 2018 Hospital. All rights reserved.
//

import UIKit
import AVFoundation


class AssetListInWareHouseViewController: BaseViewController, AVCaptureMetadataOutputObjectsDelegate {
    public var assetListView: AssetListView! {
        guard isViewLoaded else { return nil }
        return view as? AssetListView
    }
    var listReviewData : [ReviewData] = []
    var captureSession:AVCaptureSession?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    var qrCodeFrameView:UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
        darkMode = false
        setNeedsStatusBarAppearanceUpdate()
        
        self.assetListView.tableView.delegate = self
        self.assetListView.tableView.dataSource = self
        self.assetListView.tableView.register(UINib(nibName: Constants.AssetListInWareHouse.assetListInWareHouseTableViewCell, bundle: nil), forCellReuseIdentifier: Constants.AssetListInWareHouse.assetListInWareHouseTableViewCell)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false

        self.title = Constants.AssetListInWareHouse.title
        let backButton = UIBarButtonItem(image: UIImage(named: "back.png"), style: .plain, target: self, action: #selector(back))
        self.navigationItem.leftBarButtonItem  = backButton
        
        self.assetListView.tableView.tableFooterView = UIView()
    }
    
    @objc func back() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func scanQRCode(_ sender: Any) {
        let vc = QRSCannerViewController(nibName: Constants.QASCanner.QRSCannerViewController, bundle: nil)
        vc.delegate = self
        let nav = UINavigationController(rootViewController: vc)

        self.present(nav, animated: true, completion: nil)
    }
}

extension AssetListInWareHouseViewController: AddQRCodeDelegate {
    func addData(dataId : String){
        // List model should add new data and reload if dataId != ""
    }
}

extension AssetListInWareHouseViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.AssetListInWareHouse.assetListInWareHouseTableViewCell, for: indexPath) as! AssetListInWareHouseTableViewCell
        cell.imgCheck.image = indexPath.row % 2 == 0 ?  UIImage(named: "check.png") : UIImage(named: "uncheck.png")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // go to detail screen
    }
}
