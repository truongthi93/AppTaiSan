//
//  AddReviewViewController.swift
//  InventoryAssert
//
//  Created by TruongThi on 12/16/18.
//  Copyright © 2018 Hospital. All rights reserved.
//

import UIKit


enum UIUserInterfaceIdiom : Int {
    case unspecified
    case phone // iPhone and iPod touch style UI
    case pad // iPad style UI
}

class AddReviewViewController: BaseViewController, UITextFieldDelegate {
    public var addReviewView: AddReviewView! {
        guard isViewLoaded else { return nil }
        return view as? AddReviewView
    }
    var reviewType : ActionReviewType = .Add
    var reviewData = ReviewData()
    let datePicker = UIDatePicker()
    var existedWareHouse = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        darkMode = false
        setNeedsStatusBarAppearanceUpdate()
        
        self.addReviewView.tfReviewDate.delegate = self
        self.addReviewView.tfReviewer.delegate = self
        self.addReviewView.tfReviewId.delegate = self
        self.addReviewView.tfNote.delegate = self
        showDatePicker()
        self.fillData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = Constants.AddReview.title
        let backButton = UIBarButtonItem(image: UIImage(named: "back.png"), style: .plain, target: self, action: #selector(back))
        self.navigationItem.leftBarButtonItem  = backButton
        
        self.reviewType == .Add ? self.addReviewView.btnReview.setTitle(Constants.AddReview.startInventory, for: .normal) : self.addReviewView.btnReview.setTitle(Constants.AppCommon.note, for: .normal)
    }
    
    func fillData() {
        self.addReviewView.lblWareHouse.text = (self.reviewData.khoTaiSanId != nil) ? (Constants.AddReview.wareHouse + String(describing: self.reviewData.khoTaiSanId ?? -1)) : Constants.AddReview.pleaseSelectWareHouse
        self.addReviewView.tfNote.text = String(describing: self.reviewData.ghiChu ?? "")
        self.addReviewView.tfReviewer.text = String(describing: self.reviewData.nguoiUpdate ?? "")
        self.addReviewView.tfReviewDate.text = Utility.convertDateTimeFromServer(dtString: String(describing: self.reviewData.ngayTao ?? ""))
        self.addReviewView.tfReviewId.text = String(describing: self.reviewData.kiemKeTaiSanChiTietId ?? 0)
            
        let total = (self.reviewData.khoTaiSanId != nil) ? String(describing: self.reviewData.soLuongKiemKe ?? -1) : "0"
        let reviewed = (self.reviewData.khoTaiSanId != nil) ? String(describing: self.reviewData.soLuongKiemKe ?? -1) : "0"
        self.setUpTextAttributeLabel(total, reviewed)
    }
    
    func setUpTextAttributeLabel(_ total: String,_ reviewed: String) {
        let attrs1 = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17), NSAttributedString.Key.foregroundColor : UIColor.navigationBarColor]
        
        let attrs2 = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17), NSAttributedString.Key.foregroundColor : UIColor.red]
        
        let attributedString1 = NSMutableAttributedString(string: Constants.AddReview.totalAssert, attributes:attrs1)
        let attributedString2 = NSMutableAttributedString(string: total, attributes:attrs2)
        attributedString1.append(attributedString2)
        
        let attributedString3 = NSMutableAttributedString(string: Constants.AddReview.checked, attributes:attrs1)
        let attributedString4 = NSMutableAttributedString(string: reviewed, attributes:attrs2)
        attributedString3.append(attributedString4)
        
        self.addReviewView.lblTotal.attributedText = attributedString1
        self.addReviewView.lblReviewed.attributedText = attributedString3
    }
    
    @objc func back() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func validateForm() -> Bool{
        return (self.addReviewView.lblWareHouse.text != "" && self.addReviewView.tfReviewId.text != "" && self.addReviewView.tfReviewer.text != "" && self.addReviewView.tfReviewId.text != "" && self.existedWareHouse)
    }

    @IBAction func StartReview(_ sender: Any) {
        if !self.validateForm(){
            Utility.showAlertInform(title: Constants.AppCommon.error, message: Constants.AppCommon.messageFillAllInfo, context: self)
        } else {
            //call API get dc kiem ke id va pass qua man hinh moi.
            let vc = AssetListInWareHouseViewController(nibName: Constants.AssetListInWareHouse.assetListInWareHouseViewController, bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func selectWarehouse(_ sender: Any) {
        DataManager.shareInstance.getStore(token: "", tokenType: "") { (listStore, error) in
            // check code and do something
            if let list = listStore, list.count > 0{
                self.showSelectStore(list: list)
            } else {
                Utility.showAlertInform(title: "", message: "", context: self)
            }
            
        }
    }
    
    func showSelectStore(list: [StoreData]){
        let alertController = UIAlertController(title: "", message: Constants.AddReview.selectWareHouse, preferredStyle: .actionSheet)
        
        for item in list{
            alertController.addAction(UIAlertAction(title: item.tenKho ?? "", style: .default, handler: { (action) -> Void in
                self.existedWareHouse = true
                self.addReviewView.lblWareHouse.text = item.tenKho ?? ""
            } )
            )
        }
        
        let cancelButton = UIAlertAction(title: Constants.AppCommon.cancel, style: .cancel, handler: { (action) -> Void in
            print("Cancel button tapped")
        } )
        alertController.addAction(cancelButton)
        
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            if let currentPopoverpresentioncontroller = alertController.popoverPresentationController{
                currentPopoverpresentioncontroller.sourceView = self.addReviewView.lblWareHouse
                currentPopoverpresentioncontroller.sourceRect = self.addReviewView.lblWareHouse.bounds;
                currentPopoverpresentioncontroller.permittedArrowDirections = UIPopoverArrowDirection.up;
                self.present(alertController, animated: true, completion: nil)
            }
            break
        default:
            self.present(alertController, animated: true, completion: nil)
            break
        }
    }
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: Constants.AppCommon.done, style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: Constants.AppCommon.cancel, style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        self.addReviewView.tfReviewDate.inputAccessoryView = toolbar
        self.addReviewView.tfReviewDate.inputView = datePicker
    }
    
    @objc func donedatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = Constants.AppCommon.formatDate
        self.addReviewView.tfReviewDate.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ scoreText: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}
