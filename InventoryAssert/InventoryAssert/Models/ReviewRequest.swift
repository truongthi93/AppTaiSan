//
//  ReviewRequest.swift
//  InventoryAssert
//
//  Created by ThiVo on 12/20/18.
//  Copyright © 2018 Hospital. All rights reserved.
//

import Foundation
import ObjectMapper

class ReviewRequest: NSObject,Mappable{
    var kiemKeTaiSanChiTietID, taiSanKiemKeID, taiSanID, soLuongTon: Int?
    var soLuongKiemKe, khoTaiSanID: Int?
    var thoiGianCapNhat, ghiChu, ngayTao: String?
    var nguoiTao, daKiem, online: Int?
    
    init(kiemKeTaiSanChiTietID: Int?, taiSanKiemKeID: Int?, taiSanID: Int?, soLuongTon: Int?, soLuongKiemKe: Int?, khoTaiSanID: Int?, thoiGianCapNhat: String?, ghiChu: String?, ngayTao: String?, nguoiTao: Int?, daKiem: Int?, online: Int?) {
        self.kiemKeTaiSanChiTietID = kiemKeTaiSanChiTietID
        self.taiSanKiemKeID = taiSanKiemKeID
        self.taiSanID = taiSanID
        self.soLuongTon = soLuongTon
        self.soLuongKiemKe = soLuongKiemKe
        self.khoTaiSanID = khoTaiSanID
        self.thoiGianCapNhat = thoiGianCapNhat
        self.ghiChu = ghiChu
        self.ngayTao = ngayTao
        self.nguoiTao = nguoiTao
        self.daKiem = daKiem
        self.online = online
    }
    
    override init() {
    }
    
    required init?(map: Map) {
        kiemKeTaiSanChiTietID <- map["kiemKeTaiSanChiTietID"]
        taiSanKiemKeID <- map["taiSanKiemKeID"]
        taiSanID <- map["taiSanID"]
        soLuongTon <- map["soLuongTon"]
        soLuongKiemKe <- map["soLuongKiemKe"]
        khoTaiSanID <- map["khoTaiSanID"]
        thoiGianCapNhat <- map["thoiGianCapNhat"]
        ghiChu <- map["ghiChu"]
        ngayTao <- map["ngayTao"]
        nguoiTao <- map["nguoiTao"]
        daKiem <- map["daKiem"]
        online <- map["online"]
    }
    
    func mapping(map: Map) {
        kiemKeTaiSanChiTietID <- map["kiemKeTaiSanChiTietID"]
        taiSanKiemKeID <- map["taiSanKiemKeID"]
        taiSanID <- map["taiSanID"]
        soLuongTon <- map["soLuongTon"]
        soLuongKiemKe <- map["soLuongKiemKe"]
        khoTaiSanID <- map["khoTaiSanID"]
        thoiGianCapNhat <- map["thoiGianCapNhat"]
        ghiChu <- map["ghiChu"]
        ngayTao <- map["ngayTao"]
        nguoiTao <- map["nguoiTao"]
        daKiem <- map["daKiem"]
        online <- map["online"]
    }
}
