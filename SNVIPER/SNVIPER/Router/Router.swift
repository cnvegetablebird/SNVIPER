//
//  Router.swift
//  SNVIPER
//
//  Created by zsf on 2017/3/1.
//  Copyright © 2017年 zsf. All rights reserved.
//

import UIKit

public typealias ReturnBlock = (String?, Any?, [String : Any]?, UIViewController?, OpenType, PermissionType)->();

open class Router: NSObject, RouterProtocol{
    
    public var plugins: [RouterPluginProtocol] = [RouterPluginProtocol]();
    
    public required override init() {
        
    }
    
    public func routerPermissionType() -> PermissionType {
        return .inside;
    }
    
    @discardableResult
    open func handleURIAction(params: [String: Any]?, currentVC: UIViewController?, openType: OpenType, permissionType: PermissionType) -> Bool {
        
        interceptHandle(uri: RouterManager.shared.urlBase + "/" + routerUri(), params: params, currentVC: currentVC, openType: openType, permissionType: permissionType, block: self.handleAction);
        return true;
    }
    
    public func interceptHandle(uri: String, params: [String : Any]?, currentVC: UIViewController?, openType: OpenType, permissionType: PermissionType, block: ReturnBlock?) {
        
        if plugins.count > 0 {
            let plugin = plugins[0];
            plugins.removeFirst();
            let lblock: ReturnBlock = { (uri,data,params,currentVC,openType,permissionType) in
                RouterManager.shared.openUri(uri: uri!, params: params, currentVC: currentVC, openType: openType, permissionType: permissionType, block: block);
            }
            
            let open = plugin.interceptHandle(uri: uri, params: params, currentVC: currentVC, openType: openType, permissionType: permissionType, block: lblock);
            
            if open == false {
                interceptHandle(uri: uri, params: params, currentVC: currentVC, openType: openType, permissionType: permissionType, block: block);
            }
        }
        else {
            block?(uri,nil,params,currentVC,openType,permissionType);
        }
    }

    open func handleAction(uri: String?, data: Any?, params: [String : Any]?, currentVC: UIViewController?, openType: OpenType, permissionType: PermissionType) {
        let vc = routingPageWithData(data: params);
        
        if let v = vc {
            var resultVC = currentVC;
            if let topVC = currentVC {
                resultVC = topVC;
            }
            else {
                resultVC = UIWindow.visibleViewController();
            }
            if openType == .push {
                resultVC?.navigationController?.pushViewController(v, animated: true);
            }
            else {
                let nav = NavigationController(rootViewController: v);
                resultVC?.navigationController?.present(nav, animated: true, completion: nil);
            }
        }
    }
    
    open func routingPageWithData(data: Any?) -> UIViewController? {
        return nil;
    }

    open class func routerUri() -> String {
        return "";
    }
    
    public func routerUri() -> String {
        let r: Router.Type? = self.classForCoder as? Router.Type;
        return r?.routerUri() ?? "";
    }

}

