//
//  InformErrorBrokenViewController.swift
//  InventoryAssert
//
//  Created by mac on 1/19/19.
//  Copyright © 2019 Hospital. All rights reserved.
//

import UIKit
import SVProgressHUD

// define enum type for assert
enum TypeAssert {
    case addNew
    case update
}

class InformErrorBrokenViewController: BaseViewController, UITextFieldDelegate {
    var assertErrorList:[AssertError] = []
    let datePicker = UIDatePicker()
    var dateFilter: String?
    
    /*Handle input State textfile*/
    let dataPickerStates: [String] = Constants.InformErrorBroken.dataPickerStates
    /*Handle input State textfile*/
    
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
        self.informErrorBrokenView.dateFilterTf.delegate = self
        
        /*Handle input State textfile*/
        self.informErrorBrokenView.thePicker.delegate = self
        self.informErrorBrokenView.thePicker.dataSource = self
        self.informErrorBrokenView.stateFilterTf.delegate = self
        self.showPicker()
        /*Handle input State textfile*/
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
        
        self.informErrorBrokenView.onResetButton.addTarget(self, action: #selector(self.onResetButtonClick(_:)), for: .touchUpInside)
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case self.informErrorBrokenView.dateFilterTf:
            if self.informErrorBrokenView.dateFilterTf.text == "" {
                self.datePicker.setDate(Date(), animated: false)
            }
            self.setFormatDatePicker()
            break
        case self.informErrorBrokenView.stateFilterTf:
            self.initValueStatusTextField()
            break
        default:
            print("TextFieldDidBeginEditing.....")
            break
        }
    }
    
    func setFormatDatePicker(){
        let formatterApi = DateFormatter()
        formatterApi.dateFormat = Constants.AppCommon.formatDateSendApi
        let formatter = DateFormatter()
        formatter.dateFormat = Constants.AppCommon.formatDate
        self.dateFilter = formatterApi.string(from: datePicker.date)
        self.informErrorBrokenView.dateFilterTf.text = formatter.string(from: datePicker.date)
    }
    
    func showDatePicker(){
        let doneButton = UIBarButtonItem(title: Constants.AppCommon.done, style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: Constants.AppCommon.cancel, style: .plain, target: self, action: #selector(cancelDatePicker));
        let buttons = [doneButton, spaceButton, cancelButton]
        self.datePicker.setDate(Date(), animated: false)
        Utility.showDatePicker(datePicker: datePicker, textField: self.informErrorBrokenView.dateFilterTf, buttons: buttons)
        
        self.datePicker.addTarget(self, action: #selector(self.valueChanged(_:)), for: UIControl.Event.valueChanged)
        
    }
    
    @objc func valueChanged(_ datePicker: UIDatePicker) {
        let selectedDate = datePicker.date as NSDate
        print("Ngay duoc chon.....\(selectedDate)")
        self.setFormatDatePicker()
    }
    
    @objc func donedatePicker(){
        //        let formatterApi = DateFormatter()
        //        formatterApi.dateFormat = Constants.AppCommon.formatDateSendApi
        //        let formatter = DateFormatter()
        //        formatter.dateFormat = Constants.AppCommon.formatDate
        //        self.dateFilter = formatterApi.string(from: datePicker.date)
        //        self.informErrorBrokenView.dateFilterTf.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.informErrorBrokenView.dateFilterTf.text = ""
        self.view.endEditing(true)
    }
    
    
    @objc func onResetButtonClick(_ sender:UIButton) {
        self.resetTextField()
        
        SVProgressHUD.show()
        self.view.isUserInteractionEnabled = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.callAPIgetAssertErrorNearly()
        }
    }
    
    func resetTextField() {
        self.informErrorBrokenView.contentFilterTf.text = ""
        self.informErrorBrokenView.dateFilterTf.text = ""
        self.informErrorBrokenView.stateFilterTf.text = ""
        self.dateFilter = ""
        
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
        self.informErrorBrokenView.listInformTableView.tableFooterView = UIView()
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
    func showFooterView(message: String?) -> UIView {
        let viewFooter = FooterInformErrorView(frame: CGRect(x: 0, y: 0, width: self.informErrorBrokenView.listInformTableView.frame.size.width, height: self.informErrorBrokenView.listInformTableView.frame.size.height))
        return viewFooter
    }
}

extension InformErrorBrokenViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.assertErrorList.count != 0{
            return 1
        }
        return 0
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
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = CreateInformErrorBrokenViewController(nibName: Constants.InformErrorBroken.createInformErrorBrokenViewController, bundle: nil)
        vc.assertError = self.assertErrorList[indexPath.row]
        vc.type = .update
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        // action one
        let editAction = UITableViewRowAction(style: .default, title: Constants.AppCommon.update, handler: { (action, indexPath) in
            let vc = CreateInformErrorBrokenViewController(nibName: Constants.InformErrorBroken.createInformErrorBrokenViewController, bundle: nil)
            vc.assertError = self.assertErrorList[indexPath.row]
            vc.type = .update
            self.navigationController?.pushViewController(vc, animated: true)
        })
        editAction.backgroundColor = UIColor.navigationBarColor
        
        // action two
        let deleteAction = UITableViewRowAction(style: .default, title: Constants.AppCommon.delete, handler: { (action, indexPath) in
            // call APi to delete, if success remove in local list and UI, if fail show alert
            
            let buttonOk = UIAlertAction(title: Constants.AppCommon.agree, style: .default, handler: { (action) in
                // TODO: Call API update to remove item
                self.assertErrorList.remove(at: indexPath.row)
                self.informErrorBrokenView.listInformTableView.reloadData()
            })
            
            let buttonCancel = UIAlertAction(title: Constants.AppCommon.cancel, style: .cancel, handler: { (action) in
            })
            Utility.showAlert(title: Constants.AppCommon.note, message:Constants.AppCommon.messageConfirmDelete, buttons: [buttonOk, buttonCancel], context: self)
        })
        
        deleteAction.backgroundColor = UIColor.red
        
        return [deleteAction, editAction]
    }
    
}

extension InformErrorBrokenViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func showPicker(){
        let doneButton = UIBarButtonItem(title: Constants.AppCommon.done, style: .plain, target: self, action: #selector(donePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: Constants.AppCommon.cancel, style: .plain, target: self, action: #selector(cancelPicker));
        let buttons = [doneButton, spaceButton, cancelButton]
        
        Utility.showInputTextFieldPicker(pickerView: self.informErrorBrokenView.thePicker, textField: self.informErrorBrokenView.stateFilterTf, buttons: buttons)
    }
    
    func initValueStatusTextField(){
        if self.informErrorBrokenView.stateFilterTf.text == "" {
            self.informErrorBrokenView.stateFilterTf.text = self.dataPickerStates[0]
            self.informErrorBrokenView.thePicker.selectRow(0, inComponent: 0, animated: true)
        }
    }
    
    @objc func donePicker(){
        self.view.endEditing(true)
    }
    
    @objc func cancelPicker(){
        self.informErrorBrokenView.stateFilterTf.text = ""
        self.view.endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.dataPickerStates.count
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.dataPickerStates[row]
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.informErrorBrokenView.stateFilterTf.text = self.dataPickerStates[row]
    }
    
}
