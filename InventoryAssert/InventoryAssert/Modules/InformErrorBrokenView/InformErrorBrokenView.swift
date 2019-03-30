//
//  InformErrorBrokenView.swift
//  InventoryAssert
//
//  Created by mac on 1/19/19.
//  Copyright © 2019 Hospital. All rights reserved.
//

import UIKit

class InformErrorBrokenView: UIView {
    @IBOutlet weak var listInformTableView: UITableView!
    @IBOutlet weak var onFilterButton: UIButton!
    @IBOutlet weak var contentFilterTf: UITextField!
    @IBOutlet weak var stateFilterTf: UITextField!
    @IBOutlet weak var dateFilterTf: UITextField!
    @IBOutlet weak var createErrorBrokenButton: UIButton!
    @IBOutlet weak var onResetButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
