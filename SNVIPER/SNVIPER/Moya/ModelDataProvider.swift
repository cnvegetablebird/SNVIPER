//
//  ModelDataProvider.swift
//
//
//  Created by zsf on 2017/3/9.
//  Copyright © 2017年 zsf. All rights reserved.
//

import UIKit
import Moya
import Result

//public typealias RequestCacheDataCompletionBlock = ((_ model: BaseModelProtocol?, _ data: Data?, _ error: MoyaError?, _ isCache: Bool) -> Void);
//public typealias RequestDataCompletionBlock = ((_ model: BaseModelProtocol?, _ data: Data?, _ error: MoyaError?) -> Void);
//
//public protocol ModelDataProviderProtocol {
//    func requestData(isRefresh: Bool,target: BaseTargetType ,completion: @escaping RequestCacheDataCompletionBlock);
//    func requestData(target: BaseTargetType ,completion: @escaping RequestDataCompletionBlock);
//}
//
//open class ModelDataProvider<M: BaseModelProtocol,T:BaseTargetType>: ModelDataProviderProtocol{
//    
//    var api: BaseProviderProtocol = BaseProvider<T>(plugins:[]);
//    
//    var handleData: HandleNetworkData<M> = HandleNetworkData<M>();
//    
//    public init(plugins: [PluginType] = []) {
//        api = BaseProvider<T>(plugins:plugins);
//    }
//    
//    public func requestData(isRefresh: Bool,target: BaseTargetType ,completion: @escaping RequestCacheDataCompletionBlock) {
//
//        if isRefresh {
//            let model = handleData.getCacheModel(target: target);
//            let data = handleData.getCacheData(target: target);
//            
//            if let model = model {
//                completion(model, data, nil, true);
//            }
//        }
//        
//        api.requestData(target: target) { [weak self] (result) in
//            
//            switch result {
//            case let .failure(error):
//                completion(nil, nil, error, false);
//            case let .success(str):
//                print(str);
//                let model = self?.handleData.request(target: target, result: result);
//                completion(model, result.value?.data, result.error, false);
//            }
//        }
//    }
//    
//    public func requestData(target: BaseTargetType ,completion: @escaping RequestDataCompletionBlock) {
//        requestData(isRefresh: false, target: target) { (model, data, error, isCache) in
//            completion(model, data, error);
//        }
//    }
//}

