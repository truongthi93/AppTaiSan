//
//  InformErrorBrokenViewController.swift
//  InventoryAssert
//
//  Created by mac on 1/19/19.
//  Copyright © 2019 Hospital. All rights reserved.
//

import UIKit

class InformErrorBrokenViewController: BaseViewController {
    var data:[String] = []
    public var informErrorBrokenView: InformErrorBrokenView! {
        guard isViewLoaded else { return nil }
        return view as? InformErrorBrokenView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        darkMode = false
        setNeedsStatusBarAppearanceUpdate()
        self.initTableViewCell()
        self.setUpView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.title = Constants.InformErrorBroken.titleInformErrorBroken
        let backButton = UIBarButtonItem(image: UIImage(named: "back.png"), style: .plain, target: self, action: #selector(back))
        self.navigationItem.leftBarButtonItem  = backButton
    }
    
    @objc func back() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setUpView() {
    self.informErrorBrokenView.onFilterButton.addTarget(self, action: #selector(self.onFilterButtonClick(_:)), for: .touchUpInside)
    
    self.informErrorBrokenView.createErrorBrokenButton.addTarget(self, action: #selector(self.onCreateErrorBrokenButtonClick(_:)), for: .touchUpInside)
    }
    
    @objc func onFilterButtonClick(_ sender:UIButton) {
        if let contentFilter = self.informErrorBrokenView.contentFilterTf.text, !contentFilter.isEmpty {
            self.data = ["A", "B"]
        }else {
            self.data = []
            if self.data.count == 0 {
                self.informErrorBrokenView.listInformTableView.tableFooterView = self.showFooterView(message: "Error")
                self.informErrorBrokenView.listInformTableView.reloadData()

                return
            }
        }
        self.informErrorBrokenView.listInformTableView.reloadData()
    }

    @objc func onCreateErrorBrokenButtonClick(_ sender:UIButton) {
        let vc = CreateInformErrorBrokenViewController(nibName: Constants.InformErrorBroken.createInformErrorBrokenViewController, bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func initTableViewCell() {
        self.informErrorBrokenView.listInformTableView.delegate = self
        self.informErrorBrokenView.listInformTableView.dataSource = self
        self.informErrorBrokenView.listInformTableView.register(UINib(nibName: Constants.InformErrorBroken.itemInformErrorBrokenTableViewCell, bundle: nil), forCellReuseIdentifier:Constants.InformErrorBroken.itemInformErrorBrokenTableViewCell)
    }
    
    // FooterView
    func showFooterView(message: String?) -> UIView {
        let viewFooter = FooterInformErrorView(frame: CGRect(x: 0, y: 0, width: self.informErrorBrokenView.listInformTableView.frame.size.width, height: self.informErrorBrokenView.listInformTableView.frame.size.height))
        return viewFooter
    }

}

extension InformErrorBrokenViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if data.count != 0{
            return 1
        }else {
            return 0
        }
    }
    
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
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if self.data.count == 0 {
            return self.informErrorBrokenView.listInformTableView.frame.size.height
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Item: \(indexPath)")
    }
    
    
}
