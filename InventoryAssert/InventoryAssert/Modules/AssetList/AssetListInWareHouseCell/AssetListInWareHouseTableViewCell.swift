//
//  AssetListInWareHouseTableViewCell.swift
//  InventoryAssert
//
//  Created by TruongThi on 12/22/18.
//  Copyright © 2018 Hospital. All rights reserved.
//

import UIKit

class AssetListInWareHouseTableViewCell: UITableViewCell {
    @IBOutlet weak var imgCheck: UIImageView!
    
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblId: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
