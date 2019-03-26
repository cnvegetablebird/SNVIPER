//
//  UIBarButtonItemExtentions.swift
//  SNVIPER
//
//  Created by zsf on 2018/4/17.
//  Copyright © 2018年 zsf. All rights reserved.
//

import UIKit

public extension UIBarButtonItem {
    class func backBarButtonItem(target: Any?, action: Selector, imageName: String) -> UIBarButtonItem? {
        let highlightedImageName = imageName + "_pressed";
        let image = UIImage(named: imageName);
        let highlightedImage = UIImage(named: highlightedImageName);
        
        let btn = UIButton(type: .custom);
        btn.frame = CGRect(x: 0, y: 0, width: 44.0, height: 44.0);
        btn.setImage(image, for: .normal);
        btn.setImage(highlightedImage, for: .highlighted);
        btn.addTarget(target, action: action, for: .touchUpInside);
        return UIBarButtonItem(customView: btn);
    }
}
