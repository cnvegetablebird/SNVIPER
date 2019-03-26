//
//  UIImageExtention.swift
//  SNVIPER
//
//  Created by zsf on 2018/4/17.
//  Copyright © 2018年 zsf. All rights reserved.
//

import UIKit

public extension UIImage {
    func opaque() -> Bool {
        if let lcgImage = self.cgImage {
            let alphaInfo = lcgImage.alphaInfo;
            let opaque = alphaInfo == CGImageAlphaInfo.last || alphaInfo == CGImageAlphaInfo.first || alphaInfo == CGImageAlphaInfo.none;
            return opaque;
        }
        else {
            return false;
        }
    }
    
    func tint(tintColor: UIColor, blendMode: CGBlendMode = .destinationIn) -> UIImage? {
        let imageIn = self;
        let rect = CGRect(x: 0, y: 0, width: imageIn.size.width, height: imageIn.size.height);
        UIGraphicsBeginImageContextWithOptions(imageIn.size, self.opaque(), imageIn.scale);
        tintColor.setFill();
        draw(in: rect, blendMode: blendMode, alpha: 1.0);
        let tintedImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return tintedImage;
    }
}
