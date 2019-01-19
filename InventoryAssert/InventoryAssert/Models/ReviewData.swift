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
    var kiemKeTaiSanChiTietId : Int?
    var taiSanKiemKeId : Int?
    var taiSanId : Int?
    var soLuongTon : Int?
    var soLuongKiemKe : Int?
    var khoTaiSanId : Int?
    var trangThai : String?
    var thoiGianCapNhat : String?
    var ghiChu : String?
    var giaoThucXacThuc : String?
    var ngayTao : String?
    var ngayUpdate : String?
    var nguoiUpdate : String?
    var daKiem : Int?
    var nguoiLapPhieuId : String?
    var khoaPhieu : Int?
    var nguoiTao : String?
    var online : String?
    var taiSanKiemKe : [String]?
    
    init(kiemKeTaiSanChiTietId : Int?,
    taiSanKiemKeId : Int?,
    taiSanId : Int?,
    soLuongTon : Int?,
    soLuongKiemKe : Int?,
    khoTaiSanId : Int?,
    trangThai : String?,
    thoiGianCapNhat : String?,
    ghiChu : String?,
    giaoThucXacThuc : String?,
    ngayTao : String?,
    ngayUpdate : String?,
    nguoiUpdate : String?,
    daKiem : Int?,
    nguoiLapPhieuId : String?,
    khoaPhieu : Int?,
    nguoiTao : String?,
    online : String?,
    taiSanKiemKe : [String]?) {
        self.kiemKeTaiSanChiTietId = kiemKeTaiSanChiTietId
        self.taiSanKiemKeId = taiSanKiemKeId
        self.taiSanId = taiSanId
        self.soLuongTon = soLuongTon
        self.soLuongKiemKe = soLuongKiemKe
        self.khoTaiSanId = khoTaiSanId
        self.trangThai = trangThai
        self.thoiGianCapNhat = thoiGianCapNhat
        self.ghiChu = ghiChu
        self.giaoThucXacThuc = giaoThucXacThuc
        self.ngayTao = ngayTao
        self.ngayUpdate = ngayUpdate
        self.nguoiUpdate = nguoiUpdate
        self.daKiem = daKiem
        self.nguoiLapPhieuId = nguoiLapPhieuId
        self.khoaPhieu = khoaPhieu
        self.nguoiTao = nguoiTao
        self.online = online
        self.taiSanKiemKe = taiSanKiemKe
    }
    
    override init() {
    }
    
    required init?(map: Map) {
        kiemKeTaiSanChiTietId <- map["kiemKeTaiSanChiTietId"]
        taiSanKiemKeId <- map["taiSanKiemKeId"]
        taiSanId <- map["taiSanId"]
        soLuongTon <- map["soLuongTon"]
        soLuongKiemKe <- map["soLuongKiemKe"]
        khoTaiSanId <- map["khoTaiSanId"]
        trangThai <- map["trangThai"]
        thoiGianCapNhat <- map["thoiGianCapNhat"]
        ghiChu <- map["ghiChu"]
        giaoThucXacThuc <- map["giaoThucXacThuc"]
        ngayTao <- map["ngayTao"]
        ngayUpdate <- map["ngayUpdate"]
        nguoiUpdate <- map["nguoiUpdate"]
        daKiem <- map["daKiem"]
        nguoiLapPhieuId <- map["nguoiLapPhieuId"]
        khoaPhieu <- map["khoaPhieu"]
        nguoiTao <- map["nguoiTao"]
        online <- map["online"]
        taiSanKiemKe <- map["taiSanKiemKe"]
    }
    
    func mapping(map: Map) {
        kiemKeTaiSanChiTietId <- map["kiemKeTaiSanChiTietId"]
        taiSanKiemKeId <- map["taiSanKiemKeId"]
        taiSanId <- map["taiSanId"]
        soLuongTon <- map["soLuongTon"]
        soLuongKiemKe <- map["soLuongKiemKe"]
        khoTaiSanId <- map["khoTaiSanId"]
        trangThai <- map["trangThai"]
        thoiGianCapNhat <- map["thoiGianCapNhat"]
        ghiChu <- map["ghiChu"]
        giaoThucXacThuc <- map["giaoThucXacThuc"]
        ngayTao <- map["ngayTao"]
        ngayUpdate <- map["ngayUpdate"]
        nguoiUpdate <- map["nguoiUpdate"]
        daKiem <- map["daKiem"]
        nguoiLapPhieuId <- map["nguoiLapPhieuId"]
        khoaPhieu <- map["khoaPhieu"]
        nguoiTao <- map["nguoiTao"]
        online <- map["online"]
        taiSanKiemKe <- map["taiSanKiemKe"]
    }
}
