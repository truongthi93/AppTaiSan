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
        self.initTableViewCell()
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
    
    func initTableViewCell() {
        self.informErrorBrokenView.listInformTableView.delegate = self
        self.informErrorBrokenView.listInformTableView.dataSource = self
        self.informErrorBrokenView.listInformTableView.register(UINib(nibName: Constants.InformErrorBroken.itemInformErrorBrokenTableViewCell, bundle: nil), forCellReuseIdentifier:Constants.InformErrorBroken.itemInformErrorBrokenTableViewCell)
    }
}

extension InformErrorBrokenViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.InformErrorBroken.itemInformErrorBrokenTableViewCell, for: indexPath) as! ItemInformErrorBrokenTableViewCell
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Item: \(indexPath)")
    }
    
    
}
