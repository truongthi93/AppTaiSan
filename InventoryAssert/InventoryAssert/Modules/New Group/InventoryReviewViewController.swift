//
//  InventoryReviewViewController.swift
//  InventoryAssert
//
//  Created by TruongThi on 12/16/18.
//  Copyright © 2018 Hospital. All rights reserved.
//

import UIKit
import SVProgressHUD

class InventoryReviewViewController: BaseViewController {
    public var inventoryReviewView: InventoryReviewView! {
        guard isViewLoaded else { return nil }
        return view as? InventoryReviewView
    }
    var listReviewData : [ReviewData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        darkMode = false
        setNeedsStatusBarAppearanceUpdate()
        
        //Delegate, Datasource
        self.inventoryReviewView.tableView.delegate = self
        self.inventoryReviewView.tableView.dataSource = self
        self.inventoryReviewView.tableView.register(UINib(nibName: "InventoryReviewTableViewCell", bundle: nil), forCellReuseIdentifier: "InventoryReviewTableViewCell")
        //(UINib(nibName: "InventoryReviewTableViewCell", bundle: nil), forCellWithReuseIdentifier: "InventoryReviewTableViewCell")
        
        self.getReviewList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = Constants.InventoryReview.title
        let backButton = UIBarButtonItem(image: UIImage(named: "back.png"), style: .plain, target: self, action: #selector(back))
        self.navigationItem.leftBarButtonItem  = backButton
        self.inventoryReviewView.tableView.tableFooterView = UIView()
    }
    
    func getReviewList() {
        DataManager.shareInstance.getReviewList(token: "", tokenType: "") { (listReview, error) in
            if let list = listReview, list.count > 0{
                // show list here
                print("data \(list)")
                self.listReviewData = list.sorted{ ($0.soLuongKiemKe ?? 0) < ($1.soLuongKiemKe ?? 0) }
                self.inventoryReviewView.tableView.reloadData()
                SVProgressHUD.dismiss()
                self.view.isUserInteractionEnabled = true
            } else {
                // show pop up here
                SVProgressHUD.dismiss()
                self.view.isUserInteractionEnabled = true
                print("login error")
                Utility.showAlertInform(title: "Error", message: "No data", context: self)
            }
        }
    }
    
    @objc func back() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addNewInventoryReview(_ sender: Any) {
        print("addNewInventoryReview")
        let vc = AddReviewViewController(nibName: "AddReviewViewController", bundle: nil)
        vc.isAddNewReview = true
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func deleteInventoryReview(_ sender: Any) {
        print("deleteInventoryReview")
    }
    
    @IBAction func EditInventoryReview(_ sender: Any) {
        let vc = AddReviewViewController(nibName: "AddReviewViewController", bundle: nil)
        vc.isAddNewReview = false
        
        self.navigationController?.pushViewController(vc, animated: true)
        
        print("EditInventoryReview")
    }
}

extension InventoryReviewViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listReviewData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InventoryReviewTableViewCell", for: indexPath) as! InventoryReviewTableViewCell

        if let wh = self.listReviewData[indexPath.row].khoTaiSanId{
            cell.lblWareHouse.text = String(describing: wh)
        } else {
            cell.lblWareHouse.text = ""
        }
        cell.lblName.text = self.listReviewData[indexPath.row].nguoiKiemKe
        cell.lblTime.text = Utility.convertDateTimeFromServer(dtString: self.listReviewData[indexPath.row].thoiGianBatDauKiemKe ?? "")
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("")
    }
}
