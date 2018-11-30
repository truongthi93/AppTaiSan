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
    }
}
