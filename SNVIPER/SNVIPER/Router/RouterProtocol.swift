//
//  RouterProtocol.swift
//  SNVIPER
//
//  Created by zsf on 2017/3/1.
//  Copyright © 2017年 zsf. All rights reserved.
//

import UIKit

public struct PermissionType: OptionSet {
    public var rawValue: UInt
    
    public init(rawValue: UInt) {
        self.rawValue = rawValue;
    }
    public static var inside = PermissionType(rawValue: 1<<0);
    public static var outside = PermissionType(rawValue: 1<<1);
}

public protocol RouterProtocol {
    
    func routerPermissionType() -> PermissionType;
    
    @discardableResult
    func handleURIAction(params: [String: Any]?, currentVC: UIViewController?, openType: OpenType,permissionType: PermissionType) -> Bool;
    func interceptHandle(uri: String, params: [String : Any]?, currentVC: UIViewController?, openType: OpenType, permissionType: PermissionType, block: ReturnBlock?);
    
    func handleAction(uri: String?, data: Any?, params: [String : Any]?, currentVC: UIViewController?, openType: OpenType, permissionType: PermissionType);
    
    func routingPageWithData(data: Any?) -> UIViewController?;
    
    func routerUri() -> String;
}

extension RouterProtocol {
    
    public func routerPermissionType() -> PermissionType {
        return PermissionType(rawValue: UInt(UInt8(PermissionType.inside.rawValue | PermissionType.outside.rawValue)));
    }
    
    public func handleURIAction(params: [String: Any]?, currentVC: UIViewController?, openType: OpenType,permissionType: PermissionType) -> Bool {
        return true;
    }
    
    public func interceptHandle(uri: String, params: [String: Any]?, currentVC: UIViewController?, openType: OpenType, permissionType: PermissionType, block: ReturnBlock?) {
        
    }
    
    public func handleAction(uri: String?, data: Any?, params: [String : Any]?, currentVC: UIViewController?, openType: OpenType, permissionType: PermissionType) {
        
    }
    
    public func routingPageWithData(data: Any?) -> UIViewController? {
        return nil;
    }
    
    public func routerUri() -> String {
        return "";
    }
}
