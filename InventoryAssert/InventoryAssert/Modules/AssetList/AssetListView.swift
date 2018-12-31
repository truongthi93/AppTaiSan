//
//  AssetListView.swift
//  InventoryAssert
//
//  Created by TruongThi on 12/22/18.
//  Copyright © 2018 Hospital. All rights reserved.
//

import UIKit

class AssetListView: UIView {
    @IBOutlet weak var tableView: UITableView!

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
