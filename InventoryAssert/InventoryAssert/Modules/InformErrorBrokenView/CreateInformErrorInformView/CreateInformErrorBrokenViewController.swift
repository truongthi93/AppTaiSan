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

class CreateInformErrorBrokenViewController: BaseViewController {
    public var createInformErrorBrokenView: CreateInformErrorBrokenView! {
        guard isViewLoaded else { return nil }
        return view as? CreateInformErrorBrokenView
    }
    
    var assertError: AssertError?
    var subAssertErrors: [AssertError] = [
        AssertError(JSON: ["maYeuCau": "M001", "tenYeuCau": "May in"]) ?? AssertError(),
        AssertError(JSON: ["maYeuCau": "M002", "tenYeuCau": "May Photocopy"]) ?? AssertError()]
    var imageAsserts: [UIImage]? = [] //[UIImage(named: "Pic1") ?? UIImage(), UIImage(named: "Pic2")  ?? UIImage(), UIImage(named: "Pic3")  ?? UIImage()]
    
    var type: TypeAssert = .addNew
    
    override func viewDidLoad() {
        super.viewDidLoad()
        darkMode = false
        setNeedsStatusBarAppearanceUpdate()
        
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
    
    @IBAction func addPhotoButtonClick(_ sender: Any) {
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            /* get your image here */
            self.imageAsserts?.append(image)
            self.createInformErrorBrokenView.imageCollectionView.reloadData()
        }
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
        
        // action one
        let editAction = UITableViewRowAction(style: .default, title: Constants.AppCommon.update, handler: { (action, indexPath) in
            //            let vc = AddReviewViewController(nibName: Constants.AddReview.addReviewViewController, bundle: nil)
            //            vc.reviewType = ActionReviewType.Edit
            //            vc.existedWareHouse = true
            //            vc.reviewData = self.listReviewData[indexPath.row]
            //            self.navigationController?.pushViewController(vc, animated: true)
            
        })
        editAction.backgroundColor = UIColor.navigationBarColor
        
        // action two
        let deleteAction = UITableViewRowAction(style: .default, title: Constants.AppCommon.delete, handler: { (action, indexPath) in
            // call APi to delete, if success remove in local list and UI, if fail show alert
            print("Delete item in list asserts...")
            let buttonOk = UIAlertAction(title: Constants.AppCommon.agree, style: .default, handler: { (action) in
                //                DataManager.shareInstance.DeleteReview(id: self.listReviewData[indexPath.row].kiemKeTaiSanChiTietId ?? 0, completion: { (isSuccess, error) in
                //                    if isSuccess != nil, isSuccess == true{
                //                        self.listReviewData.remove(at: indexPath.row)
                //                        self.inventoryReviewView.tableView.reloadData()
                //                    } else {
                //                        Utility.showAlertInform(title: Constants.AppCommon.error, message: Constants.AppCommon.messageDeleteFailed, context: self)
                //                    }
                //                })
                
            })
            
            //            let buttonCancel = UIAlertAction(title: Constants.AppCommon.cancel, style: .cancel, handler: { (action) in
            //            })
            //            Utility.showAlert(title: Constants.AppCommon.note, message:Constants.AppCommon.messageConfirmDelete, buttons: [buttonOk, buttonCancel], context: self)
        })
        deleteAction.backgroundColor = UIColor.red
        
        return [deleteAction, editAction]
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
    
    func assetsPickerCannotAccessPhotoLibrary(controller: AssetsPickerViewController) {}
    func assetsPickerDidCancel(controller: AssetsPickerViewController) {}
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
