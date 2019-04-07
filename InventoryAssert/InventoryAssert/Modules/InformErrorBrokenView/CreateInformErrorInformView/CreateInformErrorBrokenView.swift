//
//  CreateInformErrorBrokenView.swift
//  InventoryAssert
//
//  Created by mac on 2/23/19.
//  Copyright © 2019 Hospital. All rights reserved.
//

import UIKit

class CreateInformErrorBrokenView: UIView {
    
    
    @IBOutlet weak var assetTableview: UITableView!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    @IBOutlet weak var dateRequestTf: UITextField!
    @IBOutlet weak var personRequestTf: UITextField!
    @IBOutlet weak var priorityRequestTf: UITextField!
    @IBOutlet weak var nameDeviceTf: UITextField!
    @IBOutlet weak var groupTf: UITextField!
    @IBOutlet weak var stateTf: UITextField!
    @IBOutlet weak var posititionTf: UITextField!
    @IBOutlet weak var contentRequestTf: UITextField!
    @IBOutlet weak var timeFinishRequestTf: UITextField!
    @IBOutlet weak var timeExpectedTf: UITextField!
    
    var subAssertErrors:[AssertError] = [
        AssertError(JSON: ["maYeuCau": "M001", "tenYeuCau": "May in"]) ?? AssertError(),
        AssertError(JSON: ["maYeuCau": "M002", "tenYeuCau": "May Photocopy"]) ?? AssertError()]
    var imagesAssert: [UIImage]? = [UIImage(named: "Pic1") ?? UIImage(), UIImage(named: "Pic2")  ?? UIImage(), UIImage(named: "Pic3")  ?? UIImage()]

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func setupCell(assertErrorList: AssertError?) {
        //<Collectionview Images>
        self.imageCollectionView.delegate = self
        self.imageCollectionView.dataSource = self
        self.imageCollectionView.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageCollectionViewCell")
        
        
        //edit size fr items
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        self.imageCollectionView.collectionViewLayout = layout
        //</Collectionview Images>
        
         //<TableView list sub assert>
        self.assetTableview.delegate = self
        self.assetTableview.dataSource = self
        self.assetTableview.register(UINib(nibName: "CreateInformErrorBrokenTableViewCell", bundle: nil), forCellReuseIdentifier: "CreateInformErrorBrokenTableViewCell")
        self.assetTableview.tableFooterView = UIView()
       //</TableView list sub assert>
        self.applyUIForText(assertErrorList: assertErrorList)
    }
    
    func applyUIForText(assertErrorList: AssertError?) {
        self.contentRequestTf.text = assertErrorList?.noiDung ?? ""
        self.dateRequestTf.text = assertErrorList?.ngayYeuCau ?? ""
        self.personRequestTf.text = assertErrorList?.ngayYeuCau ?? ""
        self.priorityRequestTf.text = assertErrorList?.loaiUuTien ?? ""
        self.nameDeviceTf.text = assertErrorList?.tenTrangThai ?? ""
        self.groupTf.text = assertErrorList?.loaiUuTien ?? ""
        self.stateTf.text = assertErrorList?.tenTrangThai ?? ""
        self.posititionTf.text = assertErrorList?.noiDung ?? ""
        self.contentRequestTf.text = assertErrorList?.noiDung ?? ""
        self.timeFinishRequestTf.text = assertErrorList?.thoiGianYeuCauHoanThanh ?? ""
        self.timeExpectedTf.text = assertErrorList?.thoiGianDuKienHoanThanh ?? ""
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension CreateInformErrorBrokenView: UITableViewDataSource, UITableViewDelegate {
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

extension CreateInformErrorBrokenView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //device screen size
        //        let width = UIScreen.main.bounds.size.width
        //        let height = UIScreen.main.bounds.size.height
        //calculation of cell size
        return CGSize(width: 250, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imagesAssert?.count ?? 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index = indexPath.item
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
        cell.imgAssert.image = self.imagesAssert?[index] ?? UIImage()
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
        self.imagesAssert?.remove(at: index)
        self.imageCollectionView.reloadData()
    }
}
