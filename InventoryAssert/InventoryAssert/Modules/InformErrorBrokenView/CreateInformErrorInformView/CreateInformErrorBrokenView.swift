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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func setupCell()  {
        assetTableview.delegate = self
        assetTableview.dataSource = self
        assetTableview.register(UINib(nibName: "CreateInformErrorBrokenTableViewCell", bundle: nil), forCellReuseIdentifier:  "CreateInformErrorBrokenTableViewCell")
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
}
