//
//  CacheDataModel.swift
//  SNVIPER
//
//  Created by zsf on 2017/3/3.
//  Copyright © 2017年 zsf. All rights reserved.
//

import UIKit

public class SNCacheDataModel:NSObject,NSCoding{
    var expiredTime: String = "";
    var indexedKey: String = "";
    var value: Data!;
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(expiredTime, forKey: "expiredTime");
        aCoder.encode(indexedKey, forKey: "indexedKey");
        aCoder.encode(value, forKey: "value");
    }
    
    public required init?(coder aDecoder: NSCoder) {
        expiredTime = aDecoder.decodeObject(forKey: "expiredTime") as? String ?? "";
        indexedKey = aDecoder.decodeObject(forKey: "indexedKey") as? String ?? "";
        value = (aDecoder.decodeObject(forKey: "value") as? Data) ?? Data();
    }
    override init() {
        super.init();
    }
}
