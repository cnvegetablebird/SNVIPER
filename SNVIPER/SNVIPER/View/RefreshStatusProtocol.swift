//
//  RefreshStatusProtocol.swift
//  SNVIPER
//
//  Created by zsf on 2017/2/18.
//  Copyright © 2017年 zsf. All rights reserved.
//

import UIKit
import MJRefresh

public enum WaterViewType {
    case kNone,kOnlyRefresh,kOnlyLoadMore,kRefreshAndLoadMore
}

public protocol RefreshStatusProtocol {
    
    func beginRefreshing();
    func hiddenFooter(hidden: Bool);
    func endRefreshData();
    func endLoadMoreData();
    func loadMoreNoMoreData();
    func resetNoMoreData();
    func setRefreshHeaderTitle(_ title: String!, for state: MJRefreshState);
    func setLoadingStyle(type: WaterViewType);
    func addRefreshTarget(_ target: Any!, refreshAction action: Selector!);
    func addLoadMoreTarget(_ target: Any!, loadMoreAction action: Selector!);
}

public extension RefreshStatusProtocol {
    
    public func beginRefreshing() {}
    public func hiddenFooter(hidden: Bool) {}
    public func endRefreshData() {}
    public func endLoadMoreData() {}
    public func loadMoreNoMoreData() {}
    public func resetNoMoreData() {}
    public func setRefreshHeaderTitle(_ title: String!, for state: MJRefreshState) {}
    public func setLoadingStyle(type: WaterViewType) {}
    public func addRefreshTarget(_ target: Any!, refreshAction action: Selector!) {}
    public func addLoadMoreTarget(_ target: Any!, loadMoreAction action: Selector!) {}
}
