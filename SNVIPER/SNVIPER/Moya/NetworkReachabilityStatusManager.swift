//
//  NetworkReachabilityStatusManager.swift
//  
//
//  Created by zsf on 2017/3/7.
//  Copyright © 2017年 zsf. All rights reserved.
//

import UIKit
import Alamofire

public class NetworkReachabilityStatusManager {

    public static let sharedInstance = NetworkReachabilityStatusManager();
    let manager = NetworkReachabilityManager(host: "www.baidu.com")
    
    private init() {
        
        manager?.listener = { status in
            print("Network Status Changed: \(status)")
        }
    }

    public func startListening() {
        manager?.startListening();
    }
}
