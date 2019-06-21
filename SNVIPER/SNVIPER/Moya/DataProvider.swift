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
    func refresh(target: TargetType, callbackQueue: DispatchQueue?, progress: ProgressBlock?, completion: ((_ result:Result<Moya.Response, MoyaError>?) -> Void)?) -> Cancellable?;
    
    @discardableResult
    func refresh(target: TargetType, completion: ((_ result:Result<Moya.Response, MoyaError>?) -> Void)?) -> Cancellable?;
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
    
    private func targetError(completion: ((Result<Moya.Response, MoyaError>?) -> Void)?) -> Cancellable? {
        let message = "target error";
        let error = MoyaError.underlying(NSError(domain: message, code: NSURLErrorUnknown, userInfo: nil), nil)
        let r = Result<Moya.Response, MoyaError>.failure(error);
        completion?(r);
        return nil;
    }
}

extension DataProvider: DataProviderProtocol {
    
    @discardableResult
    open func refresh(target: TargetType, callbackQueue: DispatchQueue? = .none, progress: ProgressBlock? = .none,
                               completion: ((_ result:Result<Moya.Response, MoyaError>?) -> Void)?) -> Cancellable? {
        if let t = target as? Target {
            return request(t, callbackQueue: callbackQueue, progress: progress, completion: { (result) in
                completion?(result);
            });
        }
        else {
            return targetError(completion: completion);
        }
    }
    
    @discardableResult
    open func refresh(target: TargetType,
                      completion: ((_ result:Result<Moya.Response, MoyaError>?) -> Void)?) -> Cancellable? {
        return refresh(target: target, callbackQueue: .none, progress: .none, completion: completion);
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
