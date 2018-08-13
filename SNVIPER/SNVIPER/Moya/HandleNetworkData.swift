//
//  HandleNetworkData.swift
//  
//
//  Created by zsf on 2017/3/9.
//  Copyright © 2017年 zsf. All rights reserved.
//

import UIKit
import HandyJSON
import Moya
import Result

public class HandleNetworkData<T: BaseModelProtocol> {
    
    func getCacheModel(target: BaseTargetType) -> T? {
        
        let sig = signatureString(target: target);
        let cacheModel: CacheDataModel? = CacheStore.sharedInstance.cachedObjectForKey(key: sig);
        
        if let cacheModel = cacheModel, let expiredTime = Double(cacheModel.expiredTime){
            let time: Double = Date().timeIntervalSince1970 as Double;
            if time > expiredTime {
                return nil;
            }
            else {
                let model:T? = deserializeFrom(data: cacheModel.value);
                return model;
            }
        }
        return nil;
    }
    
    func getCacheData(target: BaseTargetType) -> Data? {
        let sig = signatureString(target: target);
        let cacheModel: CacheDataModel? = CacheStore.sharedInstance.cachedObjectForKey(key: sig);
        return cacheModel?.value;
    }
    
    func setCacheModel(target: BaseTargetType, value: Data) {
        let sig = signatureString(target: target);
        CacheStore.sharedInstance.setCachedData(value: value, expiredTime: target.expiredTime, key: sig);
    }
    
    func deserializeFrom(data: Data?) -> T? {
        var model: T? = nil;
        if let data = data {
            let str =  String(data: data, encoding: String.Encoding.utf8);
            model = JSONDeserializer<T>.deserializeFrom(json: str);
        }
        return model;
    }
    
    func request(isRefresh: Bool = true, target: BaseTargetType, result: Result<Moya.Response, MoyaError>) -> T?{
        let model: T? = deserializeFrom(data: result.value?.data);
        
        if let data = result.value?.data,target.expiredTime > 0 {
            setCacheModel(target: target, value: data);
        }
        return model;
    }
    
    func signatureString(target: BaseTargetType) -> String {
        
        var sig = target.baseURL.absoluteString + target.path;
        var shouldUseQuestionMark = sig.contains("?");
        
        let params = target.customParameters;
        
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
