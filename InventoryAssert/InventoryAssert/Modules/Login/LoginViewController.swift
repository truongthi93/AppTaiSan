//
//  LoginViewController.swift
//  InventoryAssert
//
//  Created by TruongThi on 11/3/18.
//  Copyright © 2018 Hospital. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    public var loginView: LoginView! {
        guard isViewLoaded else { return nil }
        return view as? LoginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.setUpView()
    }
    
    func setUpView() {
        self.loginView.tfPassword.isSecureTextEntry = true
        self.loginView.tfPassword.placeholder = Constants.Login.passwordTfPlaceHolder
        self.loginView.tfUserName.placeholder = Constants.Login.userNameTfPlaceHolder
        self.loginView.btnLogin.setTitle(Constants.Login.loginButtonTitle, for: .normal)
        
        self.loginView.btnLogin.addTarget(self, action: #selector(self.btnClick(_:)), for: .touchUpInside)
    }
    
    @objc func btnClick(_ sender:UIButton) {
        print("My custom button action")
        let vc = MainViewController(nibName: "MainViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
