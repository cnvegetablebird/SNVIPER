//
//  BaseListModel.swift
//
//
//  Created by zsf on 2017/2/15.
//  Copyright © 2017年 zsf. All rights reserved.
//

import UIKit
import HandyJSON

open class BaseListModel<T: BaseModelProtocol>: BaseModelProtocol{
    public var nextId: String?
    public var lastPage: Bool?
    public var dataList: Array<T>?
    
    public required init() {
        
    }
    
    public func mapping(mapper: HelpingMapper) {
        mapper <<< self.dataList <-- "data";
    }
}
