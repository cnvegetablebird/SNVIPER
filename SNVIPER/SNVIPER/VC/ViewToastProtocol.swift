//
//  ViewToastProtocol.swift
//  SNVIPER
//
//  Created by zsf on 2017/2/18.
//  Copyright © 2017年 zsf. All rights reserved.
//

import UIKit
import Toast_Swift

public protocol ViewToastProtocol {
    
    /// 中心展示提示  默认0.3秒 非模态
    ///
    /// - Parameters:
    ///   - text: 显示文本
    ///   - duration: 显示多久，单位秒
    func showToastCenterWithText(text: String, duration: TimeInterval);
    
    /// 底部展示提示  默认0.3秒 非模态
    ///
    /// - Parameters:
    ///   - text: 显示文本
    ///   - duration: 显示多久，单位秒
    func showToastBottomWithText(text: String, duration: TimeInterval);
    /// 顶部展示提示  默认0.3秒 非模态
    ///
    /// - Parameters:
    ///   - text: 显示文本
    ///   - duration: 显示多久，单位秒
    func showToastTopWithText(text: String, duration: TimeInterval);
}

public extension ViewToastProtocol {
    
    /// 中心展示提示  默认0.3秒 非模态
    ///
    /// - Parameters:
    ///   - text: 显示文本
    ///   - duration: 显示多久，单位秒
    func showToastCenterWithText(text: String, duration: TimeInterval = 0.3) {
        let window = UIApplication.shared.windows.last;
        window?.makeToast(text, duration: duration, position: ToastPosition.center);
    }
    
    /// 底部展示提示  默认0.3秒 非模态
    ///
    /// - Parameters:
    ///   - text: 显示文本
    ///   - duration: 显示多久，单位秒
    func showToastBottomWithText(text: String, duration: TimeInterval = 0.3) {
        let window = UIApplication.shared.windows.last;
        window?.makeToast(text, duration: duration, position: ToastPosition.bottom);
    }
    
    /// 顶部展示提示  默认0.3秒 非模态
    ///
    /// - Parameters:
    ///   - text: 显示文本
    ///   - duration: 显示多久，单位秒
    func showToastTopWithText(text: String, duration: TimeInterval = 0.3) {
        let window = UIApplication.shared.windows.last;
        window?.makeToast(text, duration: duration, position: ToastPosition.top);
    }

}

