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
    
    func getAssertErrorBrokenDownFilter(date: String, content: String, state: String, completion: @escaping (_ result: [AssertError]?, _ error: NSError?) -> Void) {
        let tokenType = "Bearer"
        let token = "CfDJ8JrWIkOHor1Ft21hA4KyJxaN9kOzuqRz3RLtdLbSTOc-efWui3t9sEEr_ckw174hyj6NwLuYS0EaiiXRqXnjlm6n1HexIvQcVKlyuKS-SsE1ho2180DexgamLg_Ust5ebv9C6fPmGEfkIebOwhb7ce5A6HBdMmTrwtFka3sQ3MfIVcATIH5pLVLnMjufqFNjlJqlhQ97x7y6GxoBll_OPf2uTZvk06kebLxZSw_gXtoYHMBeYEZxmOrbyqDGCOZGT4FpHaK9PbIZktqBYZOXQ0MaET7gnF6jSa1KM8gc1MWQvi-vOSpxQUouWxbm5IwSC82COnc9sFFdHvEI1cSG1N165MwyF8_bBU1XPA6_ULHGsNgde72C4fznJG9td45hwFEVC2LgH7iaEr_2Fj7zkPw9HMBTV6EKJTe68tU599Eh" // Hardcode test
        let URL = "\(Constants.APIUrl.host)/Repair/Filter?RequestedDate=\(date)&RequestedContent=\(content)&StatusId=\(state)"
        let headers = [
            "Authorization": "\(tokenType) \(token)"
        ]
        //Repair/Filter?RequestedDate=2019-02-24(yyyy-MM-dd)
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseArray{(response:DataResponse<[AssertError]>) in
            if response.result.value != nil {
                completion(response.result.value,nil)
            } else {
                completion(nil,NSError(domain: "Error Domain", code: 999, userInfo: [NSLocalizedDescriptionKey: "Fail"]))
            }
        }
    }
    
    func getAssertErrorBrokenDownNearly(completion: @escaping (_ result: [AssertError]?, _ error: NSError?) -> Void) {
        let tokenType = "Bearer"
        let token = "CfDJ8JrWIkOHor1Ft21hA4KyJxYpmn8GbyWAcJ2JDr5mIpfeOweSFWDKZibr4QCw3wOfhEgcX007KKVyFHxfP_lCeJI_Nbxxf7cM6DuWyc5yZf899qV7dK-_UpEput_Xo5Kf8sM-s5COegzw5R3iQdc5D0nb3k9KuDXYioYT8MObVfKunu-Z7_AjIW7UTXN5ajPPEbGySRYzbk4hnszEVepfPC8XE5TtF3rgFSMLoYtN8lsbpVoTTThvkplXkABKYC7OtdREseM-PC-yPvTGl8jpUAXSbzRQKTLgLB_KS3MVzbdexYgWbrXSzVmeAcqJdfn4TU1vkQ6WoW7cg6-9_OYaoO8C6ZlsMfi6qwFZAYZCIllZN0Yh99Gjlv8TrXoKMvBSarVVd-eF0KfDv9R086Cb6Pv0t52wtL3B-_rwkafqEqtZ"
        let URL = "\(Constants.APIUrl.host)\(Constants.APIUrl.getRepairNearly)"
        let headers = [
            "Authorization": "\(tokenType) \(token)"
        ]

        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseArray{(response:DataResponse<[AssertError]>) in
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
    
    func getStore(token: String, tokenType: String, completion: @escaping (_ result: [StoreData]?, _ error: NSError?) -> Void) {
        let URL = "\(Constants.APIUrl.host)\(Constants.APIUrl.getStore)"
        let headers = [
            "Authorization": "\(tokenType) \(token)"
        ]
        print(headers)
        
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseArray(completionHandler: { (response: DataResponse<[StoreData]>) in
            if response.result.value != nil {
                completion(response.result.value,nil)
            } else {
                completion(nil,NSError(domain: "Error Domain", code: 999, userInfo: [NSLocalizedDescriptionKey: "Fail"]))
            }
        })
    }
    
    func getAssetsByReviewId(reviewId: Int, token: String, tokenType: String, completion: @escaping (_ result: [Asset]?, _ error: NSError?) -> Void) {
        let URL = "\(Constants.APIUrl.host)\(Constants.APIUrl.getAssetByReviewId)\(reviewId)"
        let headers = [
            "Authorization": "\(tokenType) \(token)"
        ]
        print(headers)
        
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseArray(completionHandler: { (response: DataResponse<[Asset]>) in
            if response.result.value != nil {
                completion(response.result.value,nil)
            } else {
                completion(nil,NSError(domain: "Error Domain", code: 999, userInfo: [NSLocalizedDescriptionKey: "Fail"]))
            }
        })
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
