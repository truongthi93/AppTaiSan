//
//  CreateInformErrorBrokenViewController.swift
//  InventoryAssert
//
//  Created by mac on 2/23/19.
//  Copyright © 2019 Hospital. All rights reserved.
//

import UIKit

class CreateInformErrorBrokenViewController: BaseViewController {
    public var createInformErrorBrokenView: CreateInformErrorBrokenView! {
        guard isViewLoaded else { return nil }
        return view as? CreateInformErrorBrokenView
    }
    
    var assertErrorList: AssertError?
    var type: TypeAssert = .addNew
    
    override func viewDidLoad() {
        super.viewDidLoad()
        darkMode = false
        setNeedsStatusBarAppearanceUpdate()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        
        self.title =  self.type == .addNew ? Constants.InformErrorBroken.titleCreateInformErrorBroken : Constants.InformErrorBroken.titleUpdateInformErrorBroken
        
        let backButton = UIBarButtonItem(image: UIImage(named: "back.png"), style: .plain, target: self, action: #selector(back))
        self.navigationItem.leftBarButtonItem  = backButton
        self.createInformErrorBrokenView.setupCell(assertErrorList: assertErrorList)
    }
    
    @objc func back() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
