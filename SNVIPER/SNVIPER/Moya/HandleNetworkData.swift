//
//  HandleNetworkData.swift
//  
//
//  Created by zsf on 2017/3/9.
//  Copyright © 2017年 zsf. All rights reserved.
//

import UIKit
import HandyJSON
import Moya
import Result

public class HandleNetworkData<T: BaseModelProtocol> {
    
    func deserializeFrom(data: Data?) -> T? {
        var model: T? = nil;
        if let data = data {
            let str =  String(data: data, encoding: String.Encoding.utf8);
            model = JSONDeserializer<T>.deserializeFrom(json: str);
        }
        return model;
    }
}
