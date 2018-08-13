//
//  InteractorLifeCycleProtocol.swift
//  SNVIPER
//
//  Created by shaofeng on 2017/11/19.
//  Copyright © 2017年 zsf. All rights reserved.
//

import UIKit

public protocol InteractorLifeCycleProtocol {
    
    func interactorDidLoad();
    
    func interactorWillAppear(_ animated: Bool);
    
    func interactorDidAppear(_ animated: Bool);
    
    func interactorDisappear(_ animated: Bool);
    
    func interactorDidDisappear(_ animated: Bool);
}

public extension InteractorLifeCycleProtocol {
    func interactorDidLoad() {
        
    }
    
    func interactorWillAppear(_ animated: Bool) {
        
    }
    
    func interactorDidAppear(_ animated: Bool) {
        
    }
    
    func interactorDisappear(_ animated: Bool) {
        
    }
    
    func interactorDidDisappear(_ animated: Bool) {
        
    }
}

