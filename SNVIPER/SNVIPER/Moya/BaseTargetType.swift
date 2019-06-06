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
    var isUseHTTPs: Bool { get };
    var expiredTime: Double { get };
    var timeoutInterval: Double { get };//header
    
    var customHttpHeaders: [String: String]? { get };
    var customParameters: [String: Any]? { get };
    var signatureString: String { get };
}

public extension BaseTargetType {
    var signatureString: String {
        
        var sig = self.baseURL.absoluteString + self.path;
        var shouldUseQuestionMark = sig.contains("?");
        
        let params = self.customParameters;
        
        guard let dParams = params else {
            return sig;
        }
        
        for key in dParams.keys {
            if shouldUseQuestionMark {
                if let value = dParams[key] {
                    shouldUseQuestionMark = false;
                    sig.append("?\(key)=\(value)");
                }
            }
            else {
                if let value = dParams[key] {
                    sig.append("&\(key)=\(value)");
                }
            }
        }
        return sig;
    }
}
