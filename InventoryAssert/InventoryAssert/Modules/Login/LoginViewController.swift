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

class LoginViewController: BaseViewController, UITextFieldDelegate {
    public var loginView: LoginView! {
        guard isViewLoaded else { return nil }
        return view as? LoginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        darkMode = true
        setNeedsStatusBarAppearanceUpdate()
        self.setUpView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.loginView.tfUserName.text = "Test"
        self.loginView.tfPassword.text = "webapp"
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
        // HARDCODE LOGIN
        let vc = MainViewController(nibName: Constants.MainView.mainViewController, bundle: nil)
        let nav = UINavigationController(rootViewController: vc)
        self.present(nav, animated: true, completion: nil)
        return
        
        if let username = self.loginView.tfUserName.text, !username.isEmpty, let password = self.loginView.tfPassword.text, !password.isEmpty{
            SVProgressHUD.show()
            self.view.isUserInteractionEnabled = false
            // Handle login here
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                DataManager.shareInstance.getToken(userName: username, password: password, completion: { (data, error) in
                    if let tokenData = data, let newToken = tokenData.accessToken, let newTokenType = tokenData.tokenType{
                        DataManager.shareInstance.login(userName: username, token: newToken, tokenType: newTokenType, completion: { (result, errorData) in
                            if (result != nil && result?.userId != nil){
                                let vc = MainViewController(nibName: Constants.MainView.mainViewController, bundle: nil)
                                let nav = UINavigationController(rootViewController: vc)
                                self.present(nav, animated: true, completion: nil)
                                SVProgressHUD.dismiss()
                                self.view.isUserInteractionEnabled = true
                            } else {
                                SVProgressHUD.dismiss()
                                self.view.isUserInteractionEnabled = true
                                Utility.showAlertInform(title: Constants.AppCommon.error, message: Constants.AppCommon.messageLoginFailed, context: self)
                            }
                        })
                    } else {
                        SVProgressHUD.dismiss()
                        self.view.isUserInteractionEnabled = true
                        print("login error")
                        Utility.showAlertInform(title: Constants.AppCommon.error, message: Constants.AppCommon.messageGetLoginInfoFailed, context: self)
                        
                    }
                })
            }
        } else {
            Utility.showAlertInform(title: Constants.AppCommon.error, message:Constants.AppCommon.messageFillLoginInfo, context: self)
        }
    }
}
