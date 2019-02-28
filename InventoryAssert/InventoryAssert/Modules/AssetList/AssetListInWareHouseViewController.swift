//
//  AssetListInWareHouseViewController.swift
//  InventoryAssert
//
//  Created by TruongThi on 12/22/18.
//  Copyright © 2018 Hospital. All rights reserved.
//

import UIKit
import AVFoundation
import CSV

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
        
        self.title = Constants.AssetListInWareHouse.title
        let downButton = UIBarButtonItem(image: UIImage(named: "download.png"), style: .plain, target: self, action: #selector(downCSV))
        self.navigationItem.rightBarButtonItem  = downButton

        self.assetListView.tableView.tableFooterView = UIView()
    }
    
    @objc func back() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func downCSV(){
        // Get application document directory path array
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true)
        let fileName = "data.csv";
        
        if let documentPath = paths.first {
            let filePath = NSMutableString(string: documentPath).appendingPathComponent(fileName);
            guard let stream = OutputStream(toFileAtPath: filePath, append: false) else {
                print("Export CSV Fail.")
                return
            }
            
            let csv = try? CSVWriter(stream: stream)
            
            try? csv?.write(row: ["id", "name", "age"])
            try? csv?.write(row: ["1", "foo", "12"])
            try? csv?.write(row: ["2", "bar", "24"])
            try? csv?.write(row: ["3", "bop", "25"])
            
            csv?.stream.close()
        }
    }
    
    @IBAction func scanQRCode(_ sender: Any) {
        let vc = QRSCannerViewController(nibName: Constants.QASCanner.QRSCannerViewController, bundle: nil)
        vc.delegate = self
        let nav = UINavigationController(rootViewController: vc)

        self.present(nav, animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: Any) {
        // call API to save new and update items
        print("Save...")
    }
    
    @objc func pressButton(_ sender: UIButton){ //<- needs `@objc`
        print("\(sender.tag)")
        let vc = AddNoteManualForAssetViewController(nibName: Constants.AddNote.AddNoteManualForAssetViewController, bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }}

extension AssetListInWareHouseViewController: AddQRCodeDelegate {
    func addData(dataId : String){
        // List model should add new data and reload if dataId != ""
    }
}

extension AssetListInWareHouseViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
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
        cell.btnViewMore.tag = indexPath.row
        cell.btnViewMore.addTarget(self, action: #selector(self.pressButton(_:)), for: .touchUpInside) //<- use `#selector(...)`
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // go to detail screen
    }
}
