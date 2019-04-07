//
//  ImageCollectionViewCell.swift
//  InventoryAssert
//
//  Created by mac on 4/6/19.
//  Copyright © 2019 Hospital. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgAssert: UIImageView!
    @IBOutlet weak var deleteButton: UIButton!
    var callbackDeleteItem : (()->Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func onDeleteButtonClick(_ sender: Any) {
        callbackDeleteItem?()
    }
    
}
