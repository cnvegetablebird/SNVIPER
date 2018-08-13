//
//  BaseAdapter.swift
//
//
//  Created by zsf on 2017/1/6.
//  Copyright © 2017年 zsf. All rights reserved.
//

import UIKit

open class BaseAdapter: NSObject, TouchUpDelegate {
    
    open weak var delegate: TouchUpDelegate?;
    
    open func touchUpInside(cell: Any? = nil, action: Int? = nil, object: Any? = nil, indexPath: IndexPath? = nil) {
        
    }
}
