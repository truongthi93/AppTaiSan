//
//  ListObjectTransform.swift
//  InventoryAssert
//
//  Created by TruongThi on 12/14/18.
//  Copyright © 2018 Hospital. All rights reserved.
//

import UIKit
import ObjectMapper

class ListObjectTransform<T> : TransformType where T:Mappable {
    typealias Object = Array<T>
    typealias JSON = [AnyObject]
    
    let mapper = Mapper<T>()
    
    func transformFromJSON(_ value: Any?) -> Object? {
        var results = Array<T>()
        if let value = value as? [AnyObject] {
            for json in value {
                if let obj = mapper.map(JSONObject: json) {
                    results.append(obj)
                }
            }
        }
        return results
    }
    
    func transformToJSON(_ value: Object?) -> JSON? {
        var results = [AnyObject]()
        if let value = value {
            for obj in value {
                let json = mapper.toJSON(obj)
                results.append(json as AnyObject)
            }
        }
        return results
    }
}

