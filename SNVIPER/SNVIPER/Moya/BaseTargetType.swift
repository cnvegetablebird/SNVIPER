//
//  BaseTargetType.swift
//  SNVIPER
//
//  Created by zsf on 2017/2/10.
//  Copyright © 2017年 zsf. All rights reserved.
//

import UIKit
import Moya

//public enum RequestMethod: Int {
//    case unknown = 0
//    case local
//    case query
//    case refresh
//}

public protocol BaseTargetType: TargetType {
    
    var apiVersion: String { get };
    var isUseHTTPs: Bool { get };
    var expiredTime: Double { get };
    
    var customHttpHeaders: [String: String]? { get };
    var customParameters: [String: Any]? { get };
//    var requestMethod: RequestMethod { get set }
}
