//
//  ViewHUDProtocol.swift
//  SNVIPER
//
//  Created by zsf on 2017/2/18.
//  Copyright © 2017年 zsf. All rights reserved.
//

import UIKit

public protocol ViewHUDProtocol {
    
    /// 中心展示提示，模态
    ///
    /// - Parameter text: 显示文本
    func showProgressHUDWithText(text: String);
    
    /// 隐藏模态对话框，与 showActivityViewWithText 配对使用
    func hiddenProgressHUDWithAnimated(animated: Bool);
}
