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
    @IBOutlet weak var addPhotoButton: UIButton!
    @IBOutlet weak var scanQRCodeButton: UIButton!
    @IBOutlet weak var findAssertButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func setupCell(assertError: AssertError?) {
        //<Collectionview Images>
        self.imageCollectionView.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageCollectionViewCell")
        //edit size fr items
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        self.imageCollectionView.collectionViewLayout = layout
        
        //<TableView list sub assert>
        self.assetTableview.register(UINib(nibName: "CreateInformErrorBrokenTableViewCell", bundle: nil), forCellReuseIdentifier: "CreateInformErrorBrokenTableViewCell")
        self.assetTableview.tableFooterView = UIView()
        //</TableView list sub assert>
        self.applyUIForText(assertError: assertError)
    }
    
    func applyUIForText(assertError: AssertError?) {
        self.contentRequestTf.text = assertError?.noiDung ?? ""
        self.dateRequestTf.text = assertError?.ngayYeuCau ?? ""
        self.personRequestTf.text = assertError?.ngayYeuCau ?? ""
        self.priorityRequestTf.text = assertError?.loaiUuTien ?? ""
        self.nameDeviceTf.text = assertError?.tenTrangThai ?? ""
        self.groupTf.text = assertError?.loaiUuTien ?? ""
        self.stateTf.text = assertError?.tenTrangThai ?? ""
        self.posititionTf.text = assertError?.noiDung ?? ""
        self.contentRequestTf.text = assertError?.noiDung ?? ""
        self.timeFinishRequestTf.text = assertError?.thoiGianYeuCauHoanThanh ?? ""
        self.timeExpectedTf.text = assertError?.thoiGianDuKienHoanThanh ?? ""
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

