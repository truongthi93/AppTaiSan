//
//  UserDefault.swift
//  InventoryAssert
//
//  Created by mac on 3/1/19.
//  Copyright © 2019 Hospital. All rights reserved.
//

import UIKit

class AppUserDefault {
    class func storeUserName(userName:String) -> Bool{
        let us = UserDefaults.standard
        us.set(userName, forKey: "uerName")
        return us.synchronize()
    }
    
    class func getUserName() -> String{
        return UserDefaults.standard.string(forKey: "uerName") ?? ""
    }
    
    class func storeUserToken(token:String)  -> Bool{
        let us = UserDefaults.standard
        us.set(token, forKey: "token")
        return us.synchronize()
    }
    
    class func getUserToken() -> String{
        return UserDefaults.standard.string(forKey: "token") ?? ""
    }
    
    class func storeUserTokenType(tokenType:String)  -> Bool{
        let us = UserDefaults.standard
        us.set(tokenType, forKey: "tokenType")
        return us.synchronize()
    }
    
    class func getUserTokenType(email:String) -> String{
        return UserDefaults.standard.string(forKey: "tokenType") ?? ""
    }
    
}
