//
//  StoreData.swift
//  InventoryAssert
//
//  Created by TruongThi on 2/24/19.
//  Copyright © 2019 Hospital. All rights reserved.
//
import Foundation
import ObjectMapper

class StoreData: NSObject,Mappable {
    var khoTaiSanId: Int?
    var maKho, tenKho, tenKhongDau: String?
    var khoaPhongId, loaiKhoId: Int?
    var ngayTao, nguoiUpdate, ngayUpdate, ghiChu, nguoiTao: String?
    var tamNgung: Bool?
    var idx: Int?
    var khoNguonDauVao: Bool?
    var khoChan, khoLe: String?
    var tsKhoTaiSan: [String]?
    
    init(khoTaiSanId: Int?, maKho: String?, tenKho: String?, tenKhongDau: String?, khoaPhongId: Int?, loaiKhoId: Int?, ghiChu: String?, nguoiTao: String?, ngayTao: String?, nguoiUpdate: String?, ngayUpdate: String?, tamNgung: Bool?, idx: Int?, khoNguonDauVao: Bool?, khoChan: String?, khoLe: String?, tsKhoTaiSan: [String]?) {
        self.khoTaiSanId = khoTaiSanId
        self.maKho = maKho
        self.tenKho = tenKho
        self.tenKhongDau = tenKhongDau
        self.khoaPhongId = khoaPhongId
        self.loaiKhoId = loaiKhoId
        self.ghiChu = ghiChu
        self.nguoiTao = nguoiTao
        self.ngayTao = ngayTao
        self.nguoiUpdate = nguoiUpdate
        self.ngayUpdate = ngayUpdate
        self.tamNgung = tamNgung
        self.idx = idx
        self.khoNguonDauVao = khoNguonDauVao
        self.khoChan = khoChan
        self.khoLe = khoLe
        self.tsKhoTaiSan = tsKhoTaiSan
    }
    
    required init?(map: Map) {
        khoTaiSanId <- map["khoTaiSanId"]
        maKho <- map["maKho"]
        tenKho <- map["tenKho"]
        tenKhongDau <- map["tenKhongDau"]
        khoaPhongId <- map["khoaPhongId"]
        loaiKhoId <- map["loaiKhoId"]
        ghiChu <- map["ghiChu"]
        nguoiTao <- map["nguoiTao"]
        ngayTao <- map["ngayTao"]
        nguoiUpdate <- map["nguoiUpdate"]
        ngayUpdate <- map["ngayUpdate"]
        tamNgung <- map["tamNgung"]
        idx <- map["idx"]
        khoNguonDauVao <- map["khoNguonDauVao"]
        khoChan <- map["khoChan"]
        khoLe <- map["khoLe"]
        tsKhoTaiSan <- map["tsKhoTaiSan"]
    }
    
    // Mappable
    func mapping(map: Map) {
        khoTaiSanId <- map["khoTaiSanId"]
        maKho <- map["maKho"]
        tenKho <- map["tenKho"]
        tenKhongDau <- map["tenKhongDau"]
        khoaPhongId <- map["khoaPhongId"]
        loaiKhoId <- map["loaiKhoId"]
        ghiChu <- map["ghiChu"]
        nguoiTao <- map["nguoiTao"]
        ngayTao <- map["ngayTao"]
        nguoiUpdate <- map["nguoiUpdate"]
        ngayUpdate <- map["ngayUpdate"]
        tamNgung <- map["tamNgung"]
        idx <- map["idx"]
        khoNguonDauVao <- map["khoNguonDauVao"]
        khoChan <- map["khoChan"]
        khoLe <- map["khoLe"]
        tsKhoTaiSan <- map["tsKhoTaiSan"]
    }
}
