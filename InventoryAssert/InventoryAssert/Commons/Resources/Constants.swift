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
        static let getReviewList = "api/inventory"
    }
    
    public class Login{
        static let userNameTfPlaceHolder = "Tên đăng nhập"
        static let passwordTfPlaceHolder = "Mật khẩu"
        static let loginButtonTitle = "Đăng nhập"
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
