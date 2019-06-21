//
//  BaseTargetType.swift
//  SNVIPER
//
//  Created by zsf on 2017/2/10.
//  Copyright © 2017年 zsf. All rights reserved.
//

import UIKit
import Moya

public protocol BaseTargetType: TargetType {
    
    var apiVersion: String { get };
    var expiredTime: Double { get };
    var timeoutInterval: Double { get };//header
    var customHttpHeaders: [String: String]? { get };
}
