//
//  HandyJSONModel.swift
//  SNVIPER
//
//  Created by zsf on 2018/1/18.
//  Copyright © 2018年 zsf. All rights reserved.
//

import UIKit
import HandyJSON

extension Array: HandyJSON{}

struct ReturnData<T: HandyJSON>: HandyJSON {
    var message:String?
    var returnData: T?
    var stateCode: Int = 0
}

struct ResponseData<T: HandyJSON>: HandyJSON {
    var code: Int = 0
    var data: ReturnData<T>?
}
