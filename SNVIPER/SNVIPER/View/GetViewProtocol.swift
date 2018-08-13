//
//  GetViewProtocol.swift
//  
//
//  Created by zsf on 2017/1/18.
//  Copyright © 2017年 zsf. All rights reserved.
//

import Foundation

public protocol GetTableViewProtocol {
    
    func getTableView() -> RefreshStatusProtocol;
}

public protocol GetCollectionViewProtocol {
    
    func getCollectionView() -> RefreshStatusProtocol;
}

public protocol GetScrollViewProtocol {
    
    func getScrollView() -> RefreshStatusProtocol;
}
