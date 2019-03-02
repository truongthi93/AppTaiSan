//
//  InformErrorBrokenViewController.swift
//  InventoryAssert
//
//  Created by mac on 1/19/19.
//  Copyright © 2019 Hospital. All rights reserved.
//

import UIKit
import SVProgressHUD

class InformErrorBrokenViewController: BaseViewController {
    var assertErrorList:[AssertError] = []
    let datePicker = UIDatePicker()
    var dateFilter: String?
    
    public var informErrorBrokenView: InformErrorBrokenView! {
        guard isViewLoaded else { return nil }
        return view as? InformErrorBrokenView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        darkMode = false
        setNeedsStatusBarAppearanceUpdate()
        self.initTableViewCell()
        self.setUpView()
        self.showDatePicker()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.title = Constants.InformErrorBroken.titleInformErrorBroken
        let backButton = UIBarButtonItem(image: UIImage(named: "back.png"), style: .plain, target: self, action: #selector(back))
        self.navigationItem.leftBarButtonItem  = backButton
    }
    
    @objc func back() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setUpView() {
        self.informErrorBrokenView.onFilterButton.addTarget(self, action: #selector(self.onFilterButtonClick(_:)), for: .touchUpInside)
        
        self.informErrorBrokenView.createErrorBrokenButton.addTarget(self, action: #selector(self.onCreateErrorBrokenButtonClick(_:)), for: .touchUpInside)
    }
    
    func showDatePicker(){
        let doneButton = UIBarButtonItem(title: Constants.AppCommon.done, style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: Constants.AppCommon.cancel, style: .plain, target: self, action: #selector(cancelDatePicker));
        let buttons = [doneButton, spaceButton, cancelButton]
        Utility.showDatePicker(datePicker: datePicker, textField: self.informErrorBrokenView.dateFilterTf, buttons: buttons)
    }
    
    @objc func donedatePicker(){
        let formatterApi = DateFormatter()
        formatterApi.dateFormat = Constants.AppCommon.formatDateSendApi
        let formatter = DateFormatter()
        formatter.dateFormat = Constants.AppCommon.formatDate
        self.dateFilter = formatterApi.string(from: datePicker.date)
        self.informErrorBrokenView.dateFilterTf.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.dateFilter = ""
        self.view.endEditing(true)
    }
    
    
    @objc func onFilterButtonClick(_ sender:UIButton) {
        
        let content: String? = self.informErrorBrokenView.contentFilterTf.text
        let state: String? = self.informErrorBrokenView.stateFilterTf.text
        let date: String? =  self.informErrorBrokenView.dateFilterTf.text
        
        
        SVProgressHUD.show()
        self.view.isUserInteractionEnabled = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if (content ?? "").isEmpty, (state ?? "").isEmpty, (date ?? "").isEmpty {
                self.callAPIgetAssertErrorNearly()
            }else{
                // Handle get asset error broken down here
                DataManager.shareInstance.getAssertErrorBrokenDownFilter(date: self.dateFilter ?? "", content: content ?? "", state: state ?? "", completion: { (data, error) in
                    if let assertErrorList = data {
                        if assertErrorList.isEmpty {
                            self.callAPIgetAssertErrorNearly()
                        }else{
                            self.assertErrorList = assertErrorList
                            self.view.isUserInteractionEnabled = true
                            SVProgressHUD.dismiss()
                            self.informErrorBrokenView.listInformTableView.reloadData()
                            print("List Assert........ \(assertErrorList)")
                        }
                    } else {
                        print("List Assert Filter........error")
                        SVProgressHUD.dismiss()
                        self.view.isUserInteractionEnabled = true
                        Utility.showAlertInform(title: Constants.AppCommon.error, message: Constants.AppCommon.messageGetAssertErrorBrokenFilter, context: self)
                    }
                })
            }
        }
    }
    
    @objc func onCreateErrorBrokenButtonClick(_ sender:UIButton) {
        let vc = CreateInformErrorBrokenViewController(nibName: Constants.InformErrorBroken.createInformErrorBrokenViewController, bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func initTableViewCell() {
        self.informErrorBrokenView.listInformTableView.delegate = self
        self.informErrorBrokenView.listInformTableView.dataSource = self
        self.informErrorBrokenView.listInformTableView.register(UINib(nibName: Constants.InformErrorBroken.itemInformErrorBrokenTableViewCell, bundle: nil), forCellReuseIdentifier:Constants.InformErrorBroken.itemInformErrorBrokenTableViewCell)
    }
    
    func callAPIgetAssertErrorNearly() {
        DataManager.shareInstance.getAssertErrorBrokenDownNearly(completion: { (data, error) in
            if let assertErrorList = data {
                self.assertErrorList = assertErrorList
                self.informErrorBrokenView.listInformTableView.reloadData()
            }
            else {
                print("List Assert Nearly........is empty")
                Utility.showAlertInform(title: Constants.AppCommon.error, message: Constants.AppCommon.messageGetAssertErrorBrokenNearly, context: self)
            }
            SVProgressHUD.dismiss()
            self.view.isUserInteractionEnabled = true
        })
    }
    
    // FooterView
    //    func showFooterView(message: String?) -> UIView {
    //        let viewFooter = FooterInformErrorView(frame: CGRect(x: 0, y: 0, width: self.informErrorBrokenView.listInformTableView.frame.size.width, height: self.informErrorBrokenView.listInformTableView.frame.size.height))
    //        return viewFooter
    //    }
    
}

extension InformErrorBrokenViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.assertErrorList.count != 0{
            return 1
        }else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.assertErrorList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.InformErrorBroken.itemInformErrorBrokenTableViewCell, for: indexPath) as! ItemInformErrorBrokenTableViewCell
        cell.lblRequestCode.text = "Mã yêu cầu: \(self.assertErrorList[index].maYeuCau ?? "")"
        cell.lblPersonRequest.text = "Người yêu cầu: \(self.assertErrorList[index].nguoiYeuCau ?? "")"
        cell.lblDepartment.text = "Bộ phận: Hardcode waiting api"
        cell.lblDeviceName.text = "Tên thiết bị: \(self.assertErrorList[index].tenYeuCau ?? "")"
        cell.lblState.text = "Trạng thái \(self.assertErrorList[index].tenTrangThai ?? "")"
        cell.lblPriorityLevel.text = "Độ ưu tiên \(self.assertErrorList[index].loaiUuTien ?? "")"
        cell.lblAssertName.text = "Tên tài sản: \(self.assertErrorList[index].tenYeuCau ?? "")"
        cell.lblContent.text = "Nội dung: \(self.assertErrorList[index].noiDung ?? "")"
        cell.lblDepartmentHandle.text = "Bộ phận xử lý: \(self.assertErrorList[index].nguoiTheoDoiSuaChua ?? "")"
        cell.lblAssertPosition.text = "Vị trí tài sản: Hardcode waiting api"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if self.assertErrorList.count == 0 {
            return self.informErrorBrokenView.listInformTableView.frame.size.height
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Item: \(indexPath)")
    }
    
}
