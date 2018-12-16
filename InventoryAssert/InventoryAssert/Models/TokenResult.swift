//
//  TokenResult.swift
//  InventoryAssert
//
//  Created by TruongThi on 12/16/18.
//  Copyright © 2018 Hospital. All rights reserved.
//

import UIKit
import Foundation
import ObjectMapper

class  TokenResult : NSObject,Mappable{
    var tokenType: String?
    var accessToken: String?
    var expiresIn: Int?
    
    init(tokenType: String?, accessToken: String?, expiresIn: Int?) {
        self.tokenType = tokenType
        self.accessToken = accessToken
        self.expiresIn = expiresIn
    }
    
    override init() {
    }
    
    required init?(map: Map) {
        tokenType <- map["token_type"]
        accessToken <- map["access_token"]
        expiresIn <- map["expires_in"]
    }
    
    // Mappable
    func mapping(map: Map) {
        tokenType <- map["token_type"]
        accessToken <- map["access_token"]
        expiresIn <- map["expires_in"]
    }
}
