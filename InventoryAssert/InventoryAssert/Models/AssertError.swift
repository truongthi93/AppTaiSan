//
//  AssertError.swift
//  InventoryAssert
//
//  Created by mac on 3/1/19.
//  Copyright © 2019 Hospital. All rights reserved.
//

import UIKit
import Foundation
import ObjectMapper

class AssertError: Mappable{
    var loaiUuTien_id: Int?
    var maYeuCau: String?
    var ngayYeuCau: String?
    var thoiGianYeuCau: String?
    var tenYeuCau: String?
    var noiDung: String?
    var nguoiYeuCau: String?
    var nguoiYeuCau_id: Int?
    var trangThai_id: Int?
    var thoiGianYeuCauHoanThanh: String?
    var thoiGianDuKienHoanThanh: String?
    var nguoiTheoDoiSuaChua: String?
    var nguoiTheoDoiSuaChua_id: Int?
    var giaiPhap: String?
    var tenTrangThai: String?
    var loaiUuTien: String?
   
    init(){}
    required init?(map: Map) {
        loaiUuTien_id <- map["loaiUuTien_id"]
        maYeuCau <- map["maYeuCau"]
        ngayYeuCau <- map["ngayYeuCau"]
        thoiGianYeuCau <- map["thoiGianYeuCau"]
        tenYeuCau <- map["tenYeuCau"]
        noiDung <- map["noiDung"]
        nguoiYeuCau <- map["nguoiYeuCau"]
        nguoiYeuCau_id <- map["nguoiYeuCau_id"]
        trangThai_id <- map["trangThai_id"]
        thoiGianYeuCauHoanThanh <- map["thoiGianYeuCauHoanThanh"]
        thoiGianDuKienHoanThanh <- map["thoiGianDuKienHoanThanh"]
        nguoiTheoDoiSuaChua <- map["nguoiTheoDoiSuaChua"]
        nguoiTheoDoiSuaChua_id <- map["nguoiTheoDoiSuaChua_id"]
        giaiPhap <- map["giaiPhap"]
        tenTrangThai <- map["tenTrangThai"]
        loaiUuTien <- map["loaiUuTien"]

    }

    init(loaiUuTien_id: Int?, maYeuCau: String?, ngayYeuCau: String?, thoiGianYeuCau: String?,tenYeuCau: String?, noiDung: String?, nguoiYeuCau: String?, nguoiYeuCau_id: Int?, trangThai_id: Int?, thoiGianYeuCauHoanThanh: String?, thoiGianDuKienHoanThanh: String?, nguoiTheoDoiSuaChua: String?, nguoiTheoDoiSuaChua_id: Int?, giaiPhap: String?, tenTrangThai: String?, loaiUuTien: String?) {
        self.loaiUuTien_id = loaiUuTien_id
        self.maYeuCau = maYeuCau
        self.ngayYeuCau = ngayYeuCau
        self.thoiGianYeuCau = thoiGianYeuCau
        self.tenYeuCau = tenYeuCau
        self.noiDung = noiDung
        self.nguoiYeuCau = nguoiYeuCau
        self.nguoiYeuCau_id = nguoiYeuCau_id
        self.trangThai_id = trangThai_id
        self.thoiGianYeuCauHoanThanh = thoiGianYeuCauHoanThanh
        self.thoiGianDuKienHoanThanh = thoiGianDuKienHoanThanh
        self.nguoiTheoDoiSuaChua = nguoiTheoDoiSuaChua
        self.nguoiTheoDoiSuaChua_id = nguoiTheoDoiSuaChua_id
        self.giaiPhap = giaiPhap
        self.tenTrangThai = tenTrangThai
        self.loaiUuTien = loaiUuTien
    }
    
    // Mappable
    func mapping(map: Map) {
        loaiUuTien_id <- map["loaiUuTien_id"]
        maYeuCau <- map["maYeuCau"]
        ngayYeuCau <- map["ngayYeuCau"]
        thoiGianYeuCau <- map["thoiGianYeuCau"]
        tenYeuCau <- map["tenYeuCau"]
        noiDung <- map["noiDung"]
        nguoiYeuCau <- map["nguoiYeuCau"]
        nguoiYeuCau_id <- map["nguoiYeuCau_id"]
        trangThai_id <- map["trangThai_id"]
        thoiGianYeuCauHoanThanh <- map["thoiGianYeuCauHoanThanh"]
        thoiGianDuKienHoanThanh <- map["thoiGianDuKienHoanThanh"]
        nguoiTheoDoiSuaChua <- map["nguoiTheoDoiSuaChua"]
        nguoiTheoDoiSuaChua_id <- map["nguoiTheoDoiSuaChua_id"]
        giaiPhap <- map["giaiPhap"]
        tenTrangThai <- map["tenTrangThai"]
        loaiUuTien <- map["loaiUuTien"]

    }
    
}


