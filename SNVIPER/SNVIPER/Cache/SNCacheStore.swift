//
//  CacheStore.swift
//  SNVIPER
//
//  Created by zsf on 2017/3/3.
//  Copyright © 2017年 zsf. All rights reserved.
//

import UIKit
import YYCache
import SNExtensions

public class SNCacheStore {
    
    public static let sharedInstance = SNCacheStore();
    
    private init() {
        
    }
    
    let yycache: YYCache = {
        let yycache: YYCache = YYCache(name: "SNCacheStore")!;
        yycache.memoryCache.ageLimit = 3600;
        yycache.memoryCache.autoTrimInterval = 30;
        yycache.diskCache.ageLimit = 86400 * 7;
        yycache.diskCache.freeDiskSpaceLimit = UInt(200 * 1024 * 1024);
        return yycache;
    }();
    
    public func count() -> Int {
        let cnt = yycache.diskCache.totalCount();
        return cnt;
    }
    
    public func setCachedData(value: Data, expiredTime: Double, key: String) {
        
        let md5Key = key.md5;
        let time = Date().timeIntervalSince1970 + expiredTime;
        
        let cacheModel = SNCacheDataModel();
        cacheModel.value = value;
        cacheModel.expiredTime = "\(time)";
        cacheModel.indexedKey = md5Key;
        
        setCachedObject(cachedObject: cacheModel, key: md5Key);
    }
    
    public func setCachedObject(cachedObject: SNCacheDataModel, key: String) {
        
        if key.count < 0 {
            return;
        }
        yycache.setObject(cachedObject, forKey: key);
    }
    
    public func cachedDataForKey(key: String) -> Data? {
        
        let md5Key = key.md5;
        let object = yycache.object(forKey: md5Key);
        
        if let model = object as? SNCacheDataModel {
            return model.value;
        }
        return nil;
    }
    
    public func cachedObjectForKey(key: String) -> SNCacheDataModel? {
        let md5Key = key.md5;
        let model = yycache.object(forKey: md5Key);
        return model as? SNCacheDataModel;
    }
    
    public func removeCachedObjectForKey(key: String) {
        yycache.removeObject(forKey: key);
    }
    
    public func removeCachedObjectsForKeys(keys: Array<String>) {
        for key in keys {
            yycache.removeObject(forKey: key);
        }
    }
    
    public func removeCachedObjectsBeforeDate(date: Date) {
        yycache.diskCache.trim(toAge: date.timeIntervalSince1970);
    }
    
    public func removeAllObjects() {
        yycache.removeAllObjects();
    }
}
