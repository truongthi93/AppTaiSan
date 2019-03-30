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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func setupCell(assertErrorList: AssertError?) {
        assetTableview.delegate = self
        assetTableview.dataSource = self
        assetTableview.register(UINib(nibName: "CreateInformErrorBrokenTableViewCell", bundle: nil), forCellReuseIdentifier: "CreateInformErrorBrokenTableViewCell")
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
        return 20
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
