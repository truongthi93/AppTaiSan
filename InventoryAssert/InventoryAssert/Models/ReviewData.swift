//
//  ReviewData.swift
//  InventoryAssert
//
//  Created by TruongThi on 12/16/18.
//  Copyright © 2018 Hospital. All rights reserved.
//

import UIKit
import Foundation
import ObjectMapper

class ReviewData : NSObject,Mappable {
    var taiSanKiemKeId : Int?
    var maKiemKe : String?
    var ngayLapPhieu : String?
    var thoiGianLapPhieu : String?
    var thoiGianBatDauKiemKe : String?
    var noiDungKiemKe : String?
    var khoTaiSanId : Int?
    var soLuongTaiSan : Int?
    var soLuongKiemKe : Int?
    var soLuongTaiSanMoi : String?
    var soLuongTaiSanThieu : String?
    var nguoiKiemKe : String?
    var nguoiQuanLyKho : String?
    var nguoiLapPhieuId : Int?
    var khoaPhieu : String?
    var nguoiTao : Int?
    var ngayTao : String?
    var nguoiUpdate : String?
    var ngayUpdate : String?
    var tsKiemKeChiTiet : [String]?
    
//    init(tokenType: String?, accessToken: String?, expiresIn: Int?) {
//        self.tokenType = tokenType
//        self.accessToken = accessToken
//        self.expiresIn = expiresIn
//    }
    
    override init() {
    }
    
    required init?(map: Map) {
        taiSanKiemKeId <- map["taiSanKiemKeId"]
        maKiemKe <- map["maKiemKe"]
        ngayLapPhieu <- map["ngayLapPhieu"]
        thoiGianLapPhieu <- map["thoiGianLapPhieu"]
        thoiGianBatDauKiemKe <- map["thoiGianBatDauKiemKe"]
        noiDungKiemKe <- map["noiDungKiemKe"]
        khoTaiSanId <- map["khoTaiSanId"]
        soLuongTaiSan <- map["soLuongTaiSan"]
        soLuongKiemKe <- map["soLuongKiemKe"]
        soLuongTaiSanMoi <- map["soLuongTaiSanMoi"]
        soLuongTaiSanThieu <- map["soLuongTaiSanThieu"]
        nguoiKiemKe <- map["nguoiKiemKe"]
        nguoiQuanLyKho <- map["nguoiQuanLyKho"]
        nguoiLapPhieuId <- map["nguoiLapPhieuId"]
        khoaPhieu <- map["khoaPhieu"]
        nguoiTao <- map["nguoiTao"]
        ngayTao <- map["ngayTao"]
        nguoiUpdate <- map["nguoiUpdate"]
        ngayUpdate <- map["ngayUpdate"]
        tsKiemKeChiTiet <- map["tsKiemKeChiTiet"]
    }
    
    func mapping(map: Map) {
        
        taiSanKiemKeId <- map["taiSanKiemKeId"]
        maKiemKe <- map["maKiemKe"]
        ngayLapPhieu <- map["ngayLapPhieu"]
        thoiGianLapPhieu <- map["thoiGianLapPhieu"]
        thoiGianBatDauKiemKe <- map["thoiGianBatDauKiemKe"]
        noiDungKiemKe <- map["noiDungKiemKe"]
        khoTaiSanId <- map["khoTaiSanId"]
        soLuongTaiSan <- map["soLuongTaiSan"]
        soLuongKiemKe <- map["soLuongKiemKe"]
        soLuongTaiSanMoi <- map["soLuongTaiSanMoi"]
        soLuongTaiSanThieu <- map["soLuongTaiSanThieu"]
        nguoiKiemKe <- map["nguoiKiemKe"]
        nguoiQuanLyKho <- map["nguoiQuanLyKho"]
        nguoiLapPhieuId <- map["nguoiLapPhieuId"]
        khoaPhieu <- map["khoaPhieu"]
        nguoiTao <- map["nguoiTao"]
        ngayTao <- map["ngayTao"]
        nguoiUpdate <- map["nguoiUpdate"]
        ngayUpdate <- map["ngayUpdate"]
        tsKiemKeChiTiet <- map["tsKiemKeChiTiet"]
    }
}
