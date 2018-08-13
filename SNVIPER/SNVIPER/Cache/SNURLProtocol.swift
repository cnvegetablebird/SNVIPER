//
//  SNURLProtocol.swift
//  SNVIPER
//
//  Created by zsf on 2017/5/13.
//  Copyright © 2017年 zsf. All rights reserved.
//

import UIKit

open class SNURLProtocol: URLProtocol {

    open override class func canInit(with request: URLRequest) -> Bool {
        return super.canInit(with: request);
    }
    
    open override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request;
    }
    
    override open func startLoading() {
        
    }
    
    override open func stopLoading() {
        
    }
    
    open func sendResponse(data: Data, mimeType: String) {
        let response = URLResponse();
        self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: URLCache.StoragePolicy.notAllowed);
        self.client?.urlProtocol(self, didLoad: data);
        self.client?.urlProtocolDidFinishLoading(self);
    }
}
