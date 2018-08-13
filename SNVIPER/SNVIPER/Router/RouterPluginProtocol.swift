//
//  RouterPluginProtocol.swift
//  SNVIPER
//
//  Created by zsf on 2017/6/15.
//  Copyright © 2017年 zsf. All rights reserved.
//

import UIKit

public protocol RouterPluginProtocol {
    
    func interceptHandle(uri: String, params: [String: Any]?, currentVC: UIViewController?, openType: OpenType, permissionType: PermissionType, block: @escaping ReturnBlock) -> Bool;
}
