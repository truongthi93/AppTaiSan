//
//  LoginViewController.swift
//  InventoryAssert
//
//  Created by TruongThi on 11/3/18.
//  Copyright © 2018 Hospital. All rights reserved.
//

import UIKit
import SVProgressHUD
import PromiseKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    public var loginView: LoginView! {
        guard isViewLoaded else { return nil }
        return view as? LoginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.setUpView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
    }
    func setUpView() {
        self.loginView.tfPassword.isSecureTextEntry = true
        self.loginView.tfPassword.placeholder = Constants.Login.passwordTfPlaceHolder
        self.loginView.tfUserName.placeholder = Constants.Login.userNameTfPlaceHolder
        self.loginView.btnLogin.setTitle(Constants.Login.loginButtonTitle, for: .normal)
        
        self.loginView.btnLogin.addTarget(self, action: #selector(self.btnClick(_:)), for: .touchUpInside)
    }
    
    @objc func btnClick(_ sender:UIButton) {
        if let username = self.loginView.tfUserName.text, !username.isEmpty, let password = self.loginView.tfPassword.text, !password.isEmpty{
            SVProgressHUD.show()
            self.view.isUserInteractionEnabled = false
            // Handle login here
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                DataManager.shareInstance.getToken(userName: username, password: password, completion: { (data, error) in
                    if let tokenData = data, let newToken = tokenData.accessToken, let newTokenType = tokenData.tokenType{
                        DataManager.shareInstance.login(userName: username, token: newToken, tokenType: newTokenType, completion: { (result, errorData) in
                            if (result != nil && result?.userId != nil){
                                let vc = MainViewController(nibName: "MainViewController", bundle: nil)
                                let nav = UINavigationController(rootViewController: vc)
                                self.present(nav, animated: true, completion: nil)
                                SVProgressHUD.dismiss()
                                self.view.isUserInteractionEnabled = true
                            } else {
                                SVProgressHUD.dismiss()
                                self.view.isUserInteractionEnabled = true
                                print("login error")
                                Utility.showAlertInform(title: "Error", message: "Invalid User infomation", context: self)
                            }
                        })
                    } else {
                        SVProgressHUD.dismiss()
                        self.view.isUserInteractionEnabled = true
                        print("login error")
                        Utility.showAlertInform(title: "Error", message: "Get token fail", context: self)
                        
                    }
                })
            }
        } else {
            Utility.showAlertInform(title: "Error", message: "Missing User infomation", context: self)
        }
    }
}
