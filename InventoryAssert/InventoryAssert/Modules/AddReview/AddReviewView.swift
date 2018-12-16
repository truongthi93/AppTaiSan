//
//  AddReviewView.swift
//  InventoryAssert
//
//  Created by TruongThi on 12/16/18.
//  Copyright © 2018 Hospital. All rights reserved.
//

import UIKit

class AddReviewView: UIView {
    @IBOutlet weak var btnReview: UIButton!
    @IBOutlet weak var btnChooseWareHouse: UIButton!
    @IBOutlet weak var lblWareHouse: UILabel!
    @IBOutlet weak var lblReviewId: UILabel!
    @IBOutlet weak var tfReviewId: UITextField!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblReviewed: UILabel!
    @IBOutlet weak var lblReviewer: UILabel!
    @IBOutlet weak var tfReviewer: UITextField!
    @IBOutlet weak var lblReviewDate: UILabel!
    @IBOutlet weak var tfReviewDate: UITextField!
    @IBOutlet weak var lblNote: UILabel!
    @IBOutlet weak var tfNote: UITextField!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
