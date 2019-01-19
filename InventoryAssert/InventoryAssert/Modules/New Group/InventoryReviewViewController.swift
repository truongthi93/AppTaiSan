//
//  InventoryReviewViewController.swift
//  InventoryAssert
//
//  Created by TruongThi on 12/16/18.
//  Copyright © 2018 Hospital. All rights reserved.
//

import UIKit
import SVProgressHUD

enum ActionReviewType : Int {
    case Add
    case Edit
}

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
        self.inventoryReviewView.tableView.register(UINib(nibName: Constants.InventoryReview.inventoryReviewTableViewCell, bundle: nil), forCellReuseIdentifier: Constants.InventoryReview.inventoryReviewTableViewCell)        
        self.getReviewList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = Constants.InventoryReview.title
        let backButton = UIBarButtonItem(image: UIImage(named: "back.png"), style: .plain, target: self, action: #selector(back))
        self.navigationItem.leftBarButtonItem  = backButton
        let addButton = UIBarButtonItem(
            barButtonSystemItem: UIBarButtonItem.SystemItem.add,
            target: self,
            action: #selector(addNewInventoryReview)
        )
        self.navigationItem.leftBarButtonItem  = backButton
        self.navigationItem.rightBarButtonItem  = addButton
        self.inventoryReviewView.tableView.tableFooterView = UIView()
    }
    
    func getReviewList() {
        SVProgressHUD.show()
        self.view.isUserInteractionEnabled = false

        DataManager.shareInstance.getReviewList(token: "", tokenType: "") { (listReview, error) in
            if let list = listReview, list.count > 0{
                // show list here
                self.listReviewData = list.sorted{ ($0.soLuongKiemKe ?? 0) < ($1.soLuongKiemKe ?? 0) }
                self.inventoryReviewView.tableView.reloadData()
                SVProgressHUD.dismiss()
                self.view.isUserInteractionEnabled = true
            } else {
                SVProgressHUD.dismiss()
                self.view.isUserInteractionEnabled = true
                print("login error")
                Utility.showAlertInform(title: Constants.AppCommon.error, message: Constants.AppCommon.messageNoData, context: self)
            }
        }
    }
    
    @objc func back() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func addNewInventoryReview() {
        let vc = AddReviewViewController(nibName: Constants.AddReview.addReviewViewController, bundle: nil)
        vc.reviewType = ActionReviewType.Add
        vc.reviewData = ReviewData()
        vc.existedWareHouse = false
        self.navigationController?.pushViewController(vc, animated: true)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.InventoryReview.inventoryReviewTableViewCell, for: indexPath) as! InventoryReviewTableViewCell
        
        if let wh = self.listReviewData[indexPath.row].khoTaiSanId{
            cell.lblWareHouse.text = String(describing: wh)
        } else {
            cell.lblWareHouse.text = ""
        }
        cell.lblName.text = self.listReviewData[indexPath.row].nguoiUpdate
        cell.lblTime.text = Utility.convertDateTimeFromServer(dtString: self.listReviewData[indexPath.row].thoiGianCapNhat ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // go to detail screen
        print("Select row at index: \(indexPath.row), id: \(self.listReviewData[indexPath.row].taiSanKiemKeId ?? -1)")
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        // action one
        let editAction = UITableViewRowAction(style: .default, title: Constants.AppCommon.update, handler: { (action, indexPath) in
            let vc = AddReviewViewController(nibName: Constants.AddReview.addReviewViewController, bundle: nil)
            vc.reviewType = ActionReviewType.Edit
            vc.existedWareHouse = true
            vc.reviewData = self.listReviewData[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)

        })
        editAction.backgroundColor = UIColor.blue
        
        // action two
        let deleteAction = UITableViewRowAction(style: .default, title: Constants.AppCommon.delete, handler: { (action, indexPath) in
            // call APi to delete, if success remove in local list and UI, if fail show alert
            let buttonOk = UIAlertAction(title: Constants.AppCommon.agree, style: .default, handler: { (action) in
                DataManager.shareInstance.DeleteReview(id: self.listReviewData[indexPath.row].kiemKeTaiSanChiTietId ?? 0, completion: { (isSuccess, error) in
                    if isSuccess != nil, isSuccess == true{
                        self.listReviewData.remove(at: indexPath.row)
                        self.inventoryReviewView.tableView.reloadData()
                    } else {
                        Utility.showAlertInform(title: Constants.AppCommon.error, message: Constants.AppCommon.messageDeleteFailed, context: self)
                    }
                })

            })
            
            let buttonCancel = UIAlertAction(title: Constants.AppCommon.cancel, style: .cancel, handler: { (action) in
            })
            Utility.showAlert(title: Constants.AppCommon.note, message:Constants.AppCommon.messageConfirmDelete, buttons: [buttonOk, buttonCancel], context: self)
        })
        deleteAction.backgroundColor = UIColor.red
        
        return [deleteAction, editAction]
    }
}
