//
//  CustomServerTrustPolicyManager.swift
//  SNVIPER
//
//  Created by zsf on 2017/3/7.
//  Copyright © 2017年 zsf. All rights reserved.
//

import UIKit
import Alamofire

class CustomServerTrustPolicyManager: ServerTrustPolicyManager {
    
    override func serverTrustPolicy(forHost host: String) -> ServerTrustPolicy? {
        let policy: ServerTrustPolicy? = .disableEvaluation;
        return policy
    }
}
