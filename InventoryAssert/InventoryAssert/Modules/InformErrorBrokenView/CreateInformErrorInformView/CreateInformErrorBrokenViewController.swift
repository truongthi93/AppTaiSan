//
//  CreateInformErrorBrokenViewController.swift
//  InventoryAssert
//
//  Created by mac on 2/23/19.
//  Copyright © 2019 Hospital. All rights reserved.
//

import UIKit
import AssetsPickerViewController
import Photos

class CreateInformErrorBrokenViewController: BaseViewController, UITextFieldDelegate {
    public var createInformErrorBrokenView: CreateInformErrorBrokenView! {
        guard isViewLoaded else { return nil }
        return view as? CreateInformErrorBrokenView
    }
    
    var assertError: AssertError?
    var subAssertErrors: [AssertError] = [
        AssertError(JSON: ["maYeuCau": "M001", "tenYeuCau": "May in"]) ?? AssertError(),
        AssertError(JSON: ["maYeuCau": "M002", "tenYeuCau": "May Photocopy"]) ?? AssertError()]
    var imageAsserts: [UIImage]? = [] //[UIImage(named: "Pic1") ?? UIImage(), UIImage(named: "Pic2")  ?? UIImage(), UIImage(named: "Pic3")  ?? UIImage()]
    
    /*Handle input State textfile*/
    let dataPickerStates: [String] = Constants.InformErrorBroken.dataPickerStates
    /*Handle input State textfile*/
    
    var type: TypeAssert = .addNew
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        darkMode = false
        setNeedsStatusBarAppearanceUpdate()
        
        //Handle Button Click
        self.createInformErrorBrokenView.addPhotoButton.addTarget(self, action: #selector(self.onAddPhotoButtonClick(_:)), for: .touchUpInside)
        
        self.createInformErrorBrokenView.scanQRCodeButton.addTarget(self, action: #selector(self.onScanQRCodeButtonClick(_:)), for: .touchUpInside)
        
        self.createInformErrorBrokenView.findAssertButton.addTarget(self, action: #selector(self.onFindAssertButtonClick(_:)), for: .touchUpInside)
        
        /*Handle input State textfile*/
        self.createInformErrorBrokenView.thePicker.delegate = self
        self.createInformErrorBrokenView.thePicker.dataSource = self
        self.createInformErrorBrokenView.stateTf.delegate = self
        self.showPicker()
        /*Handle input State textfile*/
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        
        self.title =  self.type == .addNew ? Constants.InformErrorBroken.titleCreateInformErrorBroken : Constants.InformErrorBroken.titleUpdateInformErrorBroken
        
        let backButton = UIBarButtonItem(image: UIImage(named: "back.png"), style: .plain, target: self, action: #selector(back))
        self.navigationItem.leftBarButtonItem  = backButton
        
        //TableView with sub_aesserts
        self.createInformErrorBrokenView.assetTableview.delegate = self
        self.createInformErrorBrokenView.assetTableview.dataSource = self
        
        //CollectionView with sub_aesserts
        self.createInformErrorBrokenView.imageCollectionView.delegate = self
        self.createInformErrorBrokenView.imageCollectionView.dataSource = self
        
        self.createInformErrorBrokenView.setupCell(assertError: self.assertError)
        
    }
    
    @objc func back() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func onAddPhotoButtonClick(_ sender:UIButton) {
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            /* get your image here */
            self.imageAsserts?.append(image)
            self.createInformErrorBrokenView.imageCollectionView.reloadData()
        }
    }
    
    @objc func onScanQRCodeButtonClick(_ sender:UIButton) {
        let vc = QRSCannerViewController(nibName: Constants.QASCanner.QRSCannerViewController, bundle: nil)
        vc.delegate = self
        let nav = UINavigationController(rootViewController: vc)
        self.present(nav, animated: true, completion: nil)
    }
    
    @objc func onFindAssertButtonClick(_ sender:UIButton) {
        let vc = AssetSearchViewController(nibName: "AssetSearchViewController", bundle: nil)
        let nav = UINavigationController(rootViewController: vc)
        self.present(nav, animated: true, completion: nil)
    }
    
}

extension CreateInformErrorBrokenViewController: AddQRCodeDelegate {
    func addData(dataId : String){
        // List model should add new data and reload if dataId != ""
        //        self.listAsset.append(Asset(kiemKeTaiSanChiTietId: 0, taiSanKiemKeId: 0, taiSanId: 0, soLuongTon: 0, soLuongKiemKe: 0, khoTaiSanId: 0, trangThai: "", thoiGianCapNhat: "", ghiChu: "", giaoThucXacThuc: "", ngayTao: "", ngayUpdate: "", nguoiUpdate: "", daKiem: 0, nguoiLapPhieuId: "", khoaPhieu: 0, nguoiTao: "", online: "", taiSanKiemKe: nil))
        //        self.assetListView.tableView.reloadData()
        print("QRCODE Success........")
    }
}

extension CreateInformErrorBrokenViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.subAssertErrors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CreateInformErrorBrokenTableViewCell", for: indexPath) as! CreateInformErrorBrokenTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        /*
         // action one
         let editAction = UITableViewRowAction(style: .default, title: Constants.AppCommon.update, handler: { (action, indexPath) in
         //            let vc = AddReviewViewController(nibName: Constants.AddReview.addReviewViewController, bundle: nil)
         //            vc.reviewType = ActionReviewType.Edit
         //            vc.existedWareHouse = true
         //            vc.reviewData = self.listReviewData[indexPath.row]
         //            self.navigationController?.pushViewController(vc, animated: true)
         
         })
         editAction.backgroundColor = UIColor.navigationBarColor
         */
        
        // action two
        let deleteAction = UITableViewRowAction(style: .default, title: Constants.AppCommon.delete, handler: { (action, indexPath) in
            // call APi to delete, if success remove in local list and UI, if fail show alert
            print("Delete item in list asserts...")
            let buttonOk = UIAlertAction(title: Constants.AppCommon.agree, style: .default, handler: { (action) in
                
                self.subAssertErrors.remove(at: indexPath.row)
                
                //                DataManager.shareInstance.DeleteReview(id: self.listReviewData[indexPath.row].kiemKeTaiSanChiTietId ?? 0, completion: { (isSuccess, error) in
                //                    if isSuccess != nil, isSuccess == true{
                //                        self.listReviewData.remove(at: indexPath.row)
                //                        self.inventoryReviewView.tableView.reloadData()
                //                    } else {
                //                        Utility.showAlertInform(title: Constants.AppCommon.error, message: Constants.AppCommon.messageDeleteFailed, context: self)
                //                    }
                //                })
                
                self.createInformErrorBrokenView.assetTableview.reloadData()
            })
            
            let buttonCancel = UIAlertAction(title: Constants.AppCommon.cancel, style: .cancel, handler: { (action) in
            })
            
            Utility.showAlert(title: Constants.AppCommon.note, message:Constants.AppCommon.messageConfirmDelete, buttons: [buttonOk, buttonCancel], context: self)
        })
        deleteAction.backgroundColor = UIColor.red
        
        return [deleteAction]        // return [deleteAction, editAction]
    }
    
}

extension CreateInformErrorBrokenViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //device screen size
        //        let width = UIScreen.main.bounds.size.width
        //        let height = UIScreen.main.bounds.size.height
        //calculation of cell size
        return CGSize(width: 250, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageAsserts?.count ?? 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index = indexPath.item
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
        cell.imgAssert.image = self.imageAsserts?[index] ?? UIImage()
        cell.callbackDeleteItem = {
            print("button pressed", indexPath.item)
            self.deleteItemHandle(at: index)
        }
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Click on Imgae...\(indexPath.item)")
    }
    
    func deleteItemHandle(at index: Int) {
        print("Delele image...\(index)")
        self.imageAsserts?.remove(at: index)
        self.createInformErrorBrokenView.imageCollectionView.reloadData()
    }
}

extension CreateInformErrorBrokenViewController: AssetsPickerViewControllerDelegate {
    
    func assetsPickerCannotAccessPhotoLibrary(controller: AssetsPickerViewController) {
        
    }
    
    func assetsPickerDidCancel(controller: AssetsPickerViewController) {
        
    }
    
    func assetsPicker(controller: AssetsPickerViewController, selected assets: [PHAsset]) {
        // do your job with selected assets
        if !assets.isEmpty {
            for assert in assets {
                let image: UIImage = Utility.convertAssertToImage(asset: assert)
                self.imageAsserts?.append(image)
            }
            print("Image in Assert List...... \(self.imageAsserts ?? [])")
            self.createInformErrorBrokenView.imageCollectionView.reloadData()
        }
    }
    
    func assetsPicker(controller: AssetsPickerViewController, shouldSelect asset: PHAsset, at indexPath: IndexPath) -> Bool {
        return true
    }
    
    //    func assetsPicker(controller: AssetsPickerViewController, didSelect asset: PHAsset, at indexPath: IndexPath) {
    //
    //    }
    //
    //    func assetsPicker(controller: AssetsPickerViewController, shouldDeselect asset: PHAsset, at indexPath: IndexPath) -> Bool {
    //        return true
    //    }
    //
    //    func assetsPicker(controller: AssetsPickerViewController, didDeselect asset: PHAsset, at indexPath: IndexPath) {
    //
    //    }
    //
}

extension CreateInformErrorBrokenViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func showPicker(){
        let doneButton = UIBarButtonItem(title: Constants.AppCommon.done, style: .plain, target: self, action: #selector(donePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: Constants.AppCommon.cancel, style: .plain, target: self, action: #selector(cancelPicker));
        let buttons = [doneButton, spaceButton, cancelButton]
        
        Utility.showInputTextFieldPicker(pickerView: self.createInformErrorBrokenView.thePicker, textField: self.createInformErrorBrokenView.stateTf, buttons: buttons)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if self.createInformErrorBrokenView.stateTf.text == "" {
            self.createInformErrorBrokenView.stateTf.text = self.dataPickerStates[0]
            self.createInformErrorBrokenView.thePicker.selectRow(0, inComponent: 0, animated: true)
        }
    }

    @objc func donePicker(){
        self.view.endEditing(true)
    }
    
    @objc func cancelPicker(){
        self.createInformErrorBrokenView.stateTf.text = ""
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
        self.createInformErrorBrokenView.stateTf.text = self.dataPickerStates[row]
    }
    
}
