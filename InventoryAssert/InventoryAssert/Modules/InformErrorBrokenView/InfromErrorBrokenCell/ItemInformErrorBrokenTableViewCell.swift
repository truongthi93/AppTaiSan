//
//  ItemInformErrorBrokenTableViewCell.swift
//  InventoryAssert
//
//  Created by mac on 1/19/19.
//  Copyright © 2019 Hospital. All rights reserved.
//

import UIKit

class ItemInformErrorBrokenTableViewCell: UITableViewCell {

    @IBOutlet weak var lblRequestCode: UILabel!
    @IBOutlet weak var lblDeviceName: UILabel!
    @IBOutlet weak var lblPersonRequest: UILabel!
    
    @IBOutlet weak var lblDepartment: UILabel!
    @IBOutlet weak var lblState: UILabel!
    
    @IBOutlet weak var lblAssertName: UILabel!
    
    @IBOutlet weak var lblContent: UILabel!
    
    @IBOutlet weak var lblAssertPosition: UILabel!
    
    @IBOutlet weak var lblDepartmentHandle: UILabel!
    
    @IBOutlet weak var lblPriorityLevel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
