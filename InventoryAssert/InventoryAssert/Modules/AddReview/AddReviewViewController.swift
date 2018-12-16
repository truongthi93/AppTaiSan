//
//  AddReviewViewController.swift
//  InventoryAssert
//
//  Created by TruongThi on 12/16/18.
//  Copyright © 2018 Hospital. All rights reserved.
//

import UIKit

class AddReviewViewController: BaseViewController, UITextFieldDelegate {

    public var addReviewView: AddReviewView! {
        guard isViewLoaded else { return nil }
        return view as? AddReviewView
    }
    var isAddNewReview = true
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        darkMode = false
        setNeedsStatusBarAppearanceUpdate()

        self.addReviewView.tfReviewDate.delegate = self
        self.addReviewView.tfReviewer.delegate = self
        self.addReviewView.tfReviewId.delegate = self
        self.addReviewView.tfNote.delegate = self
        showDatePicker()
        setUpTextAttributeLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = Constants.AddReview.title
        let backButton = UIBarButtonItem(image: UIImage(named: "back.png"), style: .plain, target: self, action: #selector(back))
        self.navigationItem.leftBarButtonItem  = backButton
    }
    
    func setUpTextAttributeLabel() {
        let attrs1 = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17), NSAttributedString.Key.foregroundColor : UIColor.black]
        
        let attrs2 = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17), NSAttributedString.Key.foregroundColor : UIColor.red]
        
        let attributedString1 = NSMutableAttributedString(string:"Tổng tài sản: ", attributes:attrs1)
        let attributedString2 = NSMutableAttributedString(string:"20", attributes:attrs2)
        attributedString1.append(attributedString2)
        
        let attributedString3 = NSMutableAttributedString(string:"Đã kiểm: ", attributes:attrs1)
        let attributedString4 = NSMutableAttributedString(string:"2", attributes:attrs2)
        attributedString3.append(attributedString4)

        self.addReviewView.lblTotal.attributedText = attributedString1
        self.addReviewView.lblReviewed.attributedText = attributedString3
    }
    @objc func back() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func StartReview(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func selectWarehouse(_ sender: Any) {
        let alertController = UIAlertController(title: "", message: "Chọn Kho", preferredStyle: .actionSheet)
        
        let kho1 = UIAlertAction(title: "Kho 1", style: .default, handler: { (action) -> Void in
            print("kho1")
            self.addReviewView.lblWareHouse.text = "Kho 1"
        } )
        let kho2 = UIAlertAction(title: "Kho 2", style: .default, handler: { (action) -> Void in
            print("kho2")
            self.addReviewView.lblWareHouse.text = "Kho 2"

        } )
        let kho3 = UIAlertAction(title: "Kho 3", style: .default, handler: { (action) -> Void in
            print("kho3")
            self.addReviewView.lblWareHouse.text = "Kho 3"
        } )

        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
            print("Cancel button tapped")
        } )
        
        
        alertController.addAction(kho3)
        alertController.addAction(kho2)
        alertController.addAction(kho1)
        alertController.addAction(cancelButton)
        
        self.navigationController!.present(alertController, animated: true, completion: nil)
    }
    
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        self.addReviewView.tfReviewDate.inputAccessoryView = toolbar
        self.addReviewView.tfReviewDate.inputView = datePicker
        
    }
    
    @objc func donedatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
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