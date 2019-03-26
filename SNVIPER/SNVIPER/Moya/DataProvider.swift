//
//  DataProvider.swift
//  SNVIPER
//
//  Created by zsf on 2018/3/13.
//  Copyright © 2018年 zsf. All rights reserved.
//

import UIKit
import Moya
import Result
import HandyJSON

let NetWorkDidConnectNotifacation = "NetWorkDidConnectNotifacation";
let NSNotificationCenterWithMarks = "NSNotificationCenterWithMarks";

public protocol DataProviderProtocol {
    
    @discardableResult
    func request<T: HandyJSON>(target: TargetType,
                               model: T.Type,
                               completion: ((_ returnData: T?, _ result:Result<Moya.Response, MoyaError>?) -> Void)?) -> Cancellable?;
    
    @discardableResult
    func refresh<T: HandyJSON>(target: TargetType,
                               model: T.Type,
                               completion: ((_ returnData: T?, _ result:Result<Moya.Response, MoyaError>?) -> Void)?) -> Cancellable?;
    
    @discardableResult
    func query<T: HandyJSON>(target: TargetType,
                             model: T.Type,
                             completion: ((_ returnData: T?, _ result:Result<Moya.Response, MoyaError>?) -> Void)?) -> Cancellable?;
    
    func local<T: HandyJSON>(target: TargetType,
                             model: T.Type)  -> (returnData: T?, result:Result<Moya.Response, MoyaError>?)?;
    
}

extension Response {
    func mapModel<T: HandyJSON>(_ type: T.Type) throws -> T {
        let jsonString = String(data: data, encoding: .utf8)
        guard let model = JSONDeserializer<T>.deserializeFrom(json: jsonString) else {
            throw MoyaError.jsonMapping(self)
        }
        return model
    }
}

open class DataProvider<Target: TargetType>: MoyaProvider<Target> {

    public override init(endpointClosure: @escaping EndpointClosure = DataProvider.endpointMapping,
                            requestClosure: @escaping RequestClosure = DataProvider<Target>.requestMapping,
                            stubClosure: @escaping StubClosure = DataProvider.neverStub,
                            callbackQueue:DispatchQueue? = nil,
                            manager: Manager = DataProvider<Target>.alamofireManager(),
                            plugins: [PluginType] = [],
                            trackInflights: Bool = false) {
        super.init(endpointClosure: endpointClosure, requestClosure: requestClosure, stubClosure: stubClosure, callbackQueue: callbackQueue, manager: manager, plugins: plugins, trackInflights: trackInflights);
    }
    
    private func targetError<T: HandyJSON>(completion: ((_ returnData: T?, _ result:Result<Moya.Response, MoyaError>?) -> Void)?) -> Cancellable? {
        let message = "target error";
        let error = MoyaError.underlying(NSError(domain: message, code: NSURLErrorUnknown, userInfo: nil), nil)
        let r = Result<Moya.Response, MoyaError>.failure(error);
        completion?(nil, r);
        return nil;
    }
}

extension DataProvider {
    
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

extension DataProvider: DataProviderProtocol {
    
    @discardableResult
    open func request<T: HandyJSON>(target: TargetType,
                               model: T.Type,
                               completion: ((_ returnData: T?, _ result:Result<Moya.Response, MoyaError>?) -> Void)?) -> Cancellable? {
        return nil;
    }
    
    @discardableResult
    open func refresh<T: HandyJSON>(target: TargetType,
                               model: T.Type,
                               completion: ((_ returnData: T?, _ result:Result<Moya.Response, MoyaError>?) -> Void)?) -> Cancellable? {
        if let t = target as? Target {
            return request(t , completion: { (result) in
                guard let returnData = try? result.value?.mapModel(model) else {
                    completion?(nil,result);
                    return;
                }
                if let t = target as? BaseTargetType, let d = result.value?.data {
                    let sig = self.signatureString(target: t);
                    CacheStore.sharedInstance.setCachedData(value: d, expiredTime: t.expiredTime, key: sig);
                }
                completion?(returnData,result);
            })
        }
        else {
            return targetError(completion: completion);
        }
    }
    
    @discardableResult
    open func query<T: HandyJSON>(target: TargetType,
                             model: T.Type,
                             completion: ((_ returnData: T?, _ result:Result<Moya.Response, MoyaError>?) -> Void)?) -> Cancellable? {
        
        let data = local(target: target, model: model);
        if let _ = data?.result?.value {
            completion?(data?.returnData, data?.result);
            return nil;
        }
        else {
            return refresh(target: target, model: model, completion: completion);
        }
        
    }
    
    open func local<T: HandyJSON>(target: TargetType,
                                      model: T.Type)  -> (returnData: T?, result:Result<Moya.Response, MoyaError>?)? {
        
        if let t = target as? BaseTargetType {
            let sig = signatureString(target: t);
            let cacheModel: CacheDataModel? = CacheStore.sharedInstance.cachedObjectForKey(key: sig);
            
            if let cacheModel = cacheModel, let expiredTime = Double(cacheModel.expiredTime){
                let time: Double = Date().timeIntervalSince1970 as Double;
                if time > expiredTime {
                    return nil;
                }
                else {
                    
                    let data = cacheModel.value;
                    
                    if let d = data {
                        let str =  String(data: d, encoding: String.Encoding.utf8);
                        let model = JSONDeserializer<T>.deserializeFrom(json: str);
                        let response = Response(statusCode: 200, data: d);
                        let r = Result<Moya.Response, MoyaError>.success(response);
                        return (model, r);
                    }
                }
            }
        }
        return nil;
    }
}

// MARK: 公用配置
public extension MoyaProvider {
    final class func endpointMapping(for target: Target) -> Endpoint {
        let lTarget = target as! BaseTargetType;
        
        let url = target.baseURL.appendingPathComponent(target.path).absoluteString
        return Endpoint(
            url: url,
            sampleResponseClosure: { .networkResponse(200, target.sampleData) },
            method: target.method,
            task: lTarget.task,
            httpHeaderFields: lTarget.headers
        )
    }
    
    final class func requestMapping(for endpoint: Endpoint, closure: RequestResultClosure) {
        
        do {
            var urlRequest = try endpoint.urlRequest()
            urlRequest.timeoutInterval = 10;
            
            if let headerFields = endpoint.httpHeaderFields {
                for key in headerFields.keys {
                    if let value = headerFields[key] {
                        urlRequest.setValue(value, forHTTPHeaderField: key);
                    }
                }
            }
            
            closure(.success(urlRequest))
        } catch MoyaError.requestMapping(let url) {
            closure(.failure(MoyaError.requestMapping(url)))
        } catch MoyaError.parameterEncoding(let error) {
            closure(.failure(MoyaError.parameterEncoding(error)))
        } catch {
            closure(.failure(MoyaError.underlying(error, nil)))
        }
    }
    
    final class func alamofireManager() -> Manager {
        
        let serverTrustPolicyManager = CustomServerTrustPolicyManager(policies: ["*": .disableEvaluation]);
        
        let configuration = URLSessionConfiguration.default;
        
        let manager = Manager(configuration: configuration, serverTrustPolicyManager: serverTrustPolicyManager);
        manager.delegate.sessionDidReceiveChallenge = CertificateTrustUtil.alamofireCertificateTrust;
        manager.startRequestsImmediately = false;
        manager.delegate.dataTaskDidReceiveResponseWithCompletion = { session, dataTask, response, completionHandler in
            
            if(NetworkReachabilityStatusManager.sharedInstance.manager?.isReachable == true) {
                NotificationCenter.default.postOnMainThread(name: NSNotification.Name(rawValue: NetWorkDidConnectNotifacation), object: nil);
            }
            let urlResponse = response as? HTTPURLResponse;
            let marks: String = urlResponse?.allHeaderFields["marks"] as! String? ?? "";
            
            if marks.count == 8 {
                NotificationCenter.default.postOnMainThread(name: NSNotification.Name(rawValue: NSNotificationCenterWithMarks), object: marks);
            }
            
            completionHandler(.allow);
        }
        return manager
    }
    
    final class func defaultPlugins() -> [PluginType] {
        return [];
    }
    
}
