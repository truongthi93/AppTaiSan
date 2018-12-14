//
//  DataManager.swift
//  InventoryAssert
//
//  Created by Anh Tran on 2018/12/14.
//  Copyright © 2018 Hospital. All rights reserved.
//

import UIKit
//import ObjectMapper
//import AlamofireObjectMapper


class DataManager: NSObject {
    
    typealias completionHandler = (AnyObject?, NSError?) -> ()
    typealias createConverSationCompletionHandler = (String?, NSError?) -> ()
    
    /// Singleton
    class var shareInstance : DataManager {
        struct Singleton {
            static let instance = DataManager()
        }
        return Singleton.instance
    }
    
    override init() {
        super.init()
    }
    
    func login(userName: String, password: String, completion: @escaping (_ result: Bool?, _ error: NSError?) -> Void) {
//        let URL = "" //Constants.linkImage
//        Ala
//        Alamofire.request(URL).responseArray(keyPath: Constants.keyPathAlamofire) { (response: DataResponse<String>) in
//            let forecastArray = response.result.value
//            if let forecastArray = forecastArray {
//                completion(true, forecastArray)
//            } else {
//                completion(false, [])
//            }
//        }
    }
    
}
