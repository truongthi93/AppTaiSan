//
//  DataManager.swift
//  InventoryAssert
//
//  Created by Anh Tran on 2018/12/14.
//  Copyright © 2018 Hospital. All rights reserved.
//

import UIKit
import ObjectMapper
import AlamofireObjectMapper
import Alamofire


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
    
    func getToken(userName: String, password: String, completion: @escaping (_ result: TokenResult?, _ error: NSError?) -> Void) {
        let URL = "\(Constants.APIUrl.host)\(Constants.APIUrl.getToken)"
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        let params = [
            "grant_type": "password",
            "username": userName,
            "password": password]
        Alamofire.request(URL, method: .post, parameters: params, encoding: URLEncoding(), headers: headers).responseObject { (response:DataResponse<TokenResult>) in
            if response.result.value != nil {
                completion(response.result.value,nil)
            } else {
                completion(nil,NSError(domain: "Error Domain", code: 999, userInfo: [NSLocalizedDescriptionKey: "Fail"]))
            }
        }
    }
    
    func login(userName: String, token: String, tokenType: String, completion: @escaping (_ result: LoginResult?, _ error: NSError?) -> Void) {
        let URL = "\(Constants.APIUrl.host)\(Constants.APIUrl.login)\(userName)"
        let headers = [
            "Authorization": "\(tokenType) \(token)"
        ]
        
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseObject {(response:DataResponse<LoginResult>) in
            if response.result.value != nil {
                completion(response.result.value,nil)
            } else {
                completion(nil,NSError(domain: "Error Domain", code: 999, userInfo: [NSLocalizedDescriptionKey: "Fail"]))
            }
        }
    }
    
    func getReviewList(token: String, tokenType: String, completion: @escaping (_ result: [ReviewData]?, _ error: NSError?) -> Void) {
        let URL = "\(Constants.APIUrl.host)\(Constants.APIUrl.getReviewList)"
        let headers = [
            "Authorization": "\(tokenType) \(token)"
        ]
        print(headers)
        
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseArray(completionHandler: { (response: DataResponse<[ReviewData]>) in
            if response.result.value != nil {
                completion(response.result.value,nil)
            } else {
                completion(nil,NSError(domain: "Error Domain", code: 999, userInfo: [NSLocalizedDescriptionKey: "Fail"]))
            }
        })
    }
    
    func DeleteReview(id: Int, completion: @escaping (_ result: Bool?, _ error: NSError?) -> Void) {
        let URL = "\(Constants.APIUrl.host)\(Constants.APIUrl.deleteReview)\(id)"
        Alamofire.request(URL, method: .delete, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            print(response)
            if let result = response.result.value, let JSON = result as? NSDictionary, let isSuccess = JSON["isSuccess"] as? Bool, isSuccess == true{
                completion(true,nil)
            } else {
                completion(false,NSError(domain: "Error Domain", code: 999, userInfo: [NSLocalizedDescriptionKey: "Fail"]))
            }
        })
    }
}
