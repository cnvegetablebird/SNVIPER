//
//  TouchUpDelegate.swift
//
//
//  Created by zsf on 2017/2/10.
//  Copyright © 2017年 zsf. All rights reserved.
//

import Foundation

public protocol TouchUpDelegate : class { //cell上控件点击,adapter实现
    func touchUpInside(cell: Any?, action: Int?, object: Any?, indexPath: IndexPath?);
}
