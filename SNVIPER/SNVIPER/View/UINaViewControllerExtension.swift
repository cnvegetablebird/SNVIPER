//
//  UINaViewControllerExtension.swift
//  SNVIPER
//
//  Created by zsf on 2018/4/17.
//  Copyright © 2018年 zsf. All rights reserved.
//

import UIKit

public extension UINavigationController {
    func rootViewController() -> UIViewController? {
        return self.viewControllers.first;
    }
}
