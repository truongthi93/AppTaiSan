//
//  Constants.swift
//  InventoryAssert
//
//  Created by TruongThi on 11/3/18.
//  Copyright © 2018 Hospital. All rights reserved.
//

import UIKit

class Constants {
    public class APIUrl{
        static let host = "http://115.79.197.84/"
        static let login = "api/user?username="
        static let getToken = "api/user/login"
    }
    
    public class Login{
        static let userNameTfPlaceHolder = "User name"
        static let passwordTfPlaceHolder = "Password"
        static let loginButtonTitle = "Log in"
        static let tagIndicator = 100
        
    }
    
    public class MainView{
        static let listFunction = ["Kiểm kê tài sản","Báo lỗi hư hỏng","Nhắc nhở","Tra cứu tài sản","Lịch bảo trì", "Ghi chú"]
        static let title = "Màn hình chính"
    }
    
    public class InventoryReview{
        static let title = "Danh sách các lần kiểm kê"
    }

    public class AddReview{
        static let title = "Thông tin phiếu"
    }

}
