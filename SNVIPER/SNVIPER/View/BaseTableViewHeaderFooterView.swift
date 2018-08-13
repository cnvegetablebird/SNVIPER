//
//  BaseTableViewHeaderFooterView.swift
//  
//
//  Created by zsf on 2017/1/6.
//  Copyright © 2017年 zsf. All rights reserved.
//

import UIKit

/// 可填充协议
public protocol TableViewHeaderFooterViewFillable {
    
    associatedtype ItemType;
    func fillHeaderFooterView(item: ItemType?,section: Int);
}

open class BaseTableViewHeaderFooterView<T>: UITableViewHeaderFooterView,TableViewHeaderFooterViewFillable {

    public typealias ItemType = T;
    
    open class var reuseId: String {
        return self.className;
    }
    
    open func fillHeaderFooterView(item: T?, section: Int) {
        
    }
}
