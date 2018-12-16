//
//  LoginResult.swift
//  InventoryAssert
//
//  Created by TruongThi on 12/14/18.
//  Copyright © 2018 Hospital. All rights reserved.
//

import UIKit
import Foundation
import ObjectMapper

class LoginResult : NSObject,Mappable{
    var userId: Int?
    var userCode, userName, userPosition: String?
    var groupAdmin, administrator: Bool?
    var token: String?
    
    init(userId: Int?, userCode: String?, userName: String?, userPosition: String?, groupAdmin: Bool?, administrator: Bool?, token: String?) {
        self.userId = userId
        self.userCode = userCode
        self.userName = userName
        self.userPosition = userPosition
        self.groupAdmin = groupAdmin
        self.administrator = administrator
        self.token = token
    }
    
    override init() {
    }
    
    // Mappable
    func mapping(map: Map) {
        userId <- map["userId"]
        userCode <- map["userCode"]
        userName <- map["userName"]
        userPosition <- map["userPosition"]
        groupAdmin <- map["groupAdmin"]
        administrator <- map["administrator"]
        token <- map["token"]
    }

    required init?(map: Map) {
        userId <- map["userId"]
        userCode <- map["userCode"]
        userName <- map["userName"]
        userPosition <- map["userPosition"]
        groupAdmin <- map["groupAdmin"]
        administrator <- map["administrator"]
        token <- map["token"]
    }
}
    
    
