//
//  UIWindowExtension.swift
//  SNVIPER
//
//  Created by zsf on 2018/6/14.
//  Copyright © 2018年 zsf. All rights reserved.
//

import UIKit

/*
1、[[[UIApplication sharedApplication] keyWindow] rootViewController] 有时为nil 比如当页面有菊花在转的时候，这个rootViewController就为nil;所以使用[[[[UIApplication sharedApplication] delegate] window] rootViewController] 或者
[[[[UIApplication sharedApplication] windows] objectAtIndex:0] rootViewController]

presentedViewController 和 presentingViewController
当A弹出B
A.presentedViewController=B
B.presentingViewController=A
*/

public extension UIWindow {
    
    class func getWindow() -> UIWindow?? {
        let window: UIWindow?? = UIApplication.shared.delegate?.window;
        return window;
    }
    
    class func rootViewController() -> UIViewController? {
        let window: UIWindow?? = UIWindow.getWindow();
        if let rootvc = window??.rootViewController {
            return rootvc;
        }
        else {
            return nil;
        }
    }

    class func visibleViewController() -> UIViewController? {
        
        let rootvc = UIWindow.rootViewController();
        return UIWindow.getVisibleViewController(vc: rootvc);
    }
    
    class func getVisibleViewController(vc: UIViewController?) -> UIViewController? {
        
        if let nav = vc as? UINavigationController {
            return UIWindow.getVisibleViewController(vc:nav.visibleViewController);
        }
        else if let tabbarvc = vc as? UITabBarController{
            return UIWindow.getVisibleViewController(vc:tabbarvc.selectedViewController);
        }
        else {
            if let presentedvc = vc?.presentedViewController {
                return UIWindow.getVisibleViewController(vc:presentedvc);
            }
            else {
                return vc;
            }
        }
    }
}
