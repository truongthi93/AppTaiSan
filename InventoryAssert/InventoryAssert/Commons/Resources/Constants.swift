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
        static let deleteReview = "api/InventoryAssetDetail?inventoryAssetDetailId="
        
        
    }
    
    public class AppCommon {
        static let formatDate = "dd/MM/yyyy"
        static let inform = "Thông báo"
        static let agree = "Đồng ý"
        static let cancel = "Huỷ bỏ"
        static let delete = "Xoá"
        static let update = "Cập nhật"
        static let note = "Chú ý"
        static let error = "Lỗi"
        static let done = "Đã xong"
        static let messageNoData = "Không có dữ liệu"
        static let messageLogout = "Bạn có muốn đăng xuất tài khoản khỏi thiết bị?"
        static let messageDeleteFailed = "Xóa kiểm kê thất bại"
        static let messageConfirmDelete = "Bạn có chắc xoá lần kiểm kê này?"
        static let messageLoginFailed = "Đăng nhập thất bại"
        static let messageGetLoginInfoFailed = "Không thể lấy thông tin đăng nhập"
        static let messageFillLoginInfo = "Vui lòng điền đầy đủ thông tin đăng nhập"
        static let messgaeScanNotFound = "Không tìm thấy kết quả scan"
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
        static let itemsCollectionViewCell = "ItemsCollectionViewCell"
        static let mainViewController = "MainViewController"
    }
    
    public class InventoryReview{
        static let title = "Danh sách các lần kiểm kê"
        static let inventoryReviewTableViewCell = "InventoryReviewTableViewCell"
        static let inventoryReviewViewController = "InventoryReviewViewController"
        
    }
    
    public class AddReview{
        static let title = "Thông tin phiếu"
        static let addReviewViewController = "AddReviewViewController"
        static let startInventory = "Bắt đầu kiểm"
        static let wareHouse = "Kho "
        static let pleaseSelectWareHouse = "Vui lòng chọn kho"
        static let totalAssert = "Tổng tài sản: "
        static let checked = "Đã kiểm: "
        static let selectWareHouse = "Chọn Kho "
        static let wareHouseOne = "Kho 1"
        static let wareHouseTwo = "Kho 2"
        static let wareHouseThree = "Kho 3"
    }
    
    public class AssetListInWareHouse{
        static let title = "Danh sách tài sản trong kho"
        static let assetListInWareHouseTableViewCell = "AssetListInWareHouseTableViewCell"
        static let assetListInWareHouseViewController = "AssetListInWareHouseViewController"
        
    }
    
    public class ConfirmAssetInfo {
        static let confirmAssetInfoViewController = "ConfirmAssetInfoViewController"
    }
    
    public class QASCanner {
        static let title = "Quét mã QR"
        static let QRSCannerViewController = "QRSCannerViewController"
        static let resultScan = "Kết quả Scan:"
    }
    
    public class InformErrorBroken {
        static let title = "Báo lỗi hư hỏng"
        static let InformErrorBrokenViewController = "InformErrorBrokenViewController"
    }

    
}
