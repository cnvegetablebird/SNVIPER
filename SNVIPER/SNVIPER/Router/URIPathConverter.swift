//
//  URIPathConverter.swift
//  SNVIPER
//
//  Created by zsf on 2017/6/14.
//  Copyright © 2017年 zsf. All rights reserved.
//

import UIKit
import SNExtensions

public let URIHttp = "http";
public let URLKey = "url";

public class URIPathConverter {
    
    public func checkValidUri(uri: String) -> Bool {
        return uri.hasPrefix(RouterManager.shared.urlBase) || uri.hasPrefix(URIHttp);
    }
    
    public func uriToRouterPath(uri: String) -> (path: String?, params: Dictionary<String, String>?) {
        
        if uri.isEmpty {//uri为空
            
            return (nil, nil);
        }
        
        if uri.isValideUrl {//uri为URL
            return (URIHttp, [URLKey: uri]);
        }
        
        let componentString: String = uri.replacingOccurrences(of: RouterManager.shared.urlBase + "/", with: "");//删除URIBase
        
        if componentString.isValideUrl {//如果为URL
            return (URIHttp, [URLKey: componentString]);
        }
        
        if componentString.isEmpty { //如果删除URIBase后为空
            return (nil, nil);
        }
        
        var pathComponent: String?;
        var queryConponent: String?;
        
        let range: Range? = componentString.range(of: "?");
        
        if let _ = range {
            
            var componentArr: Array = componentString.components(separatedBy: "?");
            
            if componentArr.count > 0 {
                pathComponent = componentArr.first;
            }
            
            if componentArr.count > 1 {
                queryConponent = componentArr[1];
            }
        }
        else {
            pathComponent = componentString;
        }
        
        if let p = pathComponent, p.isEmpty == false {
            let (path,uriData) = pathToRouterPath(path: p);
            var dic = queryToParams(query: queryConponent ?? "");
            
            if let d = uriData {
                for k in d.keys {
                    dic?[k] = d[k];
                }
            }
            return (path, dic);
        }
        
        return (nil, nil);
    }
    
    func pathToRouterPath(path: String) -> (path: String?, params: Dictionary<String, String>?) {//path分割成Uri和params
        
        var paths: Array<String> = path.components(separatedBy: "/");
        
        let firstPath = paths.first;
        
        if firstPath?.isEmpty == true {
            
            paths.removeFirst();
        }
        
        var params: Dictionary<String,String> = Dictionary<String,String>();
        
        for (index, element) in paths.enumerated() {
            
            let num: Int64? = Int64(element);
            
            if num != nil && index > 0 {
                
                params[paths[index-1]] = element;
                paths[index] = "#";
            }
        }
        
        let path = paths.joined(separator: "/");
        
        return (path, params);
    }
    
    func queryToParams(query: String) -> Dictionary<String, String>? {
        
        let queryParams: Array<String> = query.components(separatedBy: "&");
        var params = Dictionary<String,String>();
        
        for query in queryParams {
            let queryParams = query.components(separatedBy: "=")
            
            if queryParams.count == 2 {
                
                if let key: String = queryParams.first, let value: String = queryParams.last {
                    params[key] = value;
                }
            }
        }
        return params;
    }
}
