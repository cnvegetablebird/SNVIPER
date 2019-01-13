//
//  NavigationController.swift
//
//
//  Created by zsf on 2018/12/6.
//  Copyright © 2018 zsf. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        //如果不是根控制器 栈底控制器 才需要隐藏 根控制器不需要隐藏
        //注意super 之前和之后的问题的区别 childViewControllers.count > 1
        if children.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        
        super.pushViewController(viewController, animated:true)
    }
}
