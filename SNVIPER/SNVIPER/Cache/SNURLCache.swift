//
//  SNURLCache.swift
//  SNVIPER
//
//  Created by zsf on 2017/4/7.
//  Copyright © 2017年 zsf. All rights reserved.
//

import UIKit
import SNExtensions

open class SNURLCache: URLCache {
    
    open override func cachedResponse(for request: URLRequest) -> CachedURLResponse? {
        
        let url = request.url;
    
        if url?.toString.contains("ttf") ?? false {
            
            let songTi = Bundle.main.path(forResource: "han", ofType: ".ttf");
            
            let data = try? Data(contentsOf: URL(fileURLWithPath: songTi!));
            
            let response = URLResponse(url: url!, mimeType: "text/plain", expectedContentLength: data!.count, textEncodingName: nil);
            let cachedURLResponse = CachedURLResponse(response: response, data: data!);
            return cachedURLResponse;
        }
        
        return super.cachedResponse(for: request);
    }
}
