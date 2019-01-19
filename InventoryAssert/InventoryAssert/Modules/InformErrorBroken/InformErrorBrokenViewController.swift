//
//  InformErrorBrokenViewController.swift
//  InventoryAssert
//
//  Created by mac on 1/19/19.
//  Copyright © 2019 Hospital. All rights reserved.
//

import UIKit

class InformErrorBrokenViewController: BaseViewController {
    public var informErrorBrokenView: InformErrorBrokenView! {
        guard isViewLoaded else { return nil }
        return view as? InformErrorBrokenView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        darkMode = false
        setNeedsStatusBarAppearanceUpdate()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.title = Constants.InformErrorBroken.title
        let backButton = UIBarButtonItem(image: UIImage(named: "back.png"), style: .plain, target: self, action: #selector(back))
        self.navigationItem.leftBarButtonItem  = backButton
    }
    
    @objc func back() {
        self.navigationController?.popViewController(animated: true)
    }
}
