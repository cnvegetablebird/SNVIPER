//
//  RouterManager.swift
//  SNVIPER
//
//  Created by zsf on 2017/6/13.
//  Copyright © 2017年 zsf. All rights reserved.
//

import UIKit

public enum OpenType {
    case push, present
}

public class RouterManager {
    
    public var urlBase: String = "xxxxxx://com.xxxxxx";
    
    public static let shared = RouterManager();
    
    private var routerPool: Dictionary<String, String> = Dictionary<String, String>();
    
    private var uriPathConverter: URIPathConverter = URIPathConverter();
    
    private init() {
        
    }
    
    public func registerRouter(uri: String, routerName: String) {
        
        routerPool[uri] = routerName;
    }
    
    @discardableResult
    public func openUri(uri: String,
                        params: Dictionary<String, Any>? = nil,
                        currentVC: UIViewController? = nil,
                        openType: OpenType = .push,
                        permissionType: PermissionType = .inside,
                        block: ReturnBlock? = nil) -> Bool {
        
        var open = false;
        
        if uriPathConverter.checkValidUri(uri: uri) {
            
            let (path, paramsDic) = uriPathConverter.uriToRouterPath(uri: uri);
            
            var dic: Dictionary<String, Any> = Dictionary<String, Any>();
            
            if let lp = paramsDic {
                
                for (key, value) in lp {
                    dic[key] = value;
                }
            }
            
            if let lp = params {
                for (key, value) in lp {
                    dic[key] = value;
                }
            }
            
            open = self.openString(path: path, params: dic, currentVC: currentVC, openType: openType, permissionType: permissionType, block: block);

        }
        else {
            open = self.openString(path: uri, params: params, currentVC: currentVC, openType: openType, permissionType: permissionType, block: block);
        }
        
        return open;
    }
    @discardableResult
    private func openString(path: String?,
                            params: Dictionary<String, Any>? = nil,
                            currentVC: UIViewController? = nil,
                            openType: OpenType = .push,
                            permissionType: PermissionType = .inside,
                            block: ReturnBlock? = nil) -> Bool {
        var open = false;
        if let p = path {
            
            if let routerName: String = routerPool[p] {
                
                let classType = NSClassFromString(routerName) as? Router.Type;
                
                let router = classType?.init();
                
                if permissionType == router?.routerPermissionType(){
                    open = router?.handleURIAction(params: params, currentVC: currentVC, openType: openType, permissionType: permissionType) ?? false;
                }
            }
        }
        return open;
    }
}
