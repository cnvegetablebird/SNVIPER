//
//  UIViewControllerExtension.swift
//  SNVIPER
//
//  Created by zsf on 2018/4/17.
//  Copyright © 2018年 zsf. All rights reserved.
//

import UIKit

public extension UIViewController {
    var isPresented: Bool {
        var viewController = self;
        if let vc = self.navigationController {
            if (vc.rootViewController() != self) {
                return false;
            }
            viewController = vc;
        }
        let result = viewController.presentingViewController?.presentedViewController == viewController;
        return result;
    }
    
    var tabBarHeight: CGFloat {
        return self.tabBarController?.tabBar.bounds.height ?? 0;
    }
    
    var navBarHeight: CGFloat {
        return self.navigationController?.navigationBar.bounds.height ?? 0;
    }
}
