//
//  EmptyViewProtocol.swift
//  SNVIPER
//
//  Created by zsf on 2017/2/18.
//  Copyright © 2017年 zsf. All rights reserved.
//

import UIKit
import MJRefresh

public protocol EmptyViewProtocol {
    /// 显示空页面
    func showEmptyView();
    
    /// 隐藏空页面
    func hiddenEmptyView();
    
}

public extension EmptyViewProtocol where Self: UIViewController {

    func showEmptyView() {};
    func hiddenEmptyView() {};
}

