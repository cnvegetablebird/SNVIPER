//
//  UIScrollView+Refresh.swift
//  SNVIPER
//
//  Created by zsf on 2017/2/18.
//  Copyright © 2017年 zsf. All rights reserved.
//

import UIKit
import MJRefresh

extension UIScrollView {
    
    /// 生成refreshHeader
    ///
    /// - Returns: refreshHeader
    fileprivate func refreshHeader() -> MJRefreshNormalHeader {
        let header: MJRefreshNormalHeader = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(startRefresh));
        header.lastUpdatedTimeLabel.isHidden = true;
        header.setTitle("正在刷新", for: .refreshing);
        return header;
    }
    
    /// 生成loadMoreFooter
    ///
    /// - Returns: footer
    fileprivate func loadMoreFooter() -> MJRefreshAutoNormalFooter
    {
        let footer: MJRefreshAutoNormalFooter = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(startLoadMore));
        footer.setTitle("加载更多......", for: .refreshing);
        footer.setTitle("点击加载更多", for: .idle);
        footer.isAutomaticallyRefresh = true;
        return footer;
    }
    
    /// 下拉调用
    @objc func startRefresh()
    {
        
    }
    
    /// 上拉调用
    @objc func startLoadMore()
    {
        
    }
}

extension UIScrollView: RefreshStatusProtocol {
    
    public func beginRefreshing() {
        
        if let _ = self.mj_header {
            self.mj_header.beginRefreshing();
        }
    }
    
    public func hiddenFooter(hidden: Bool) {
        
        if let _ = self.mj_footer {
            self.mj_footer.isHidden = hidden;
        }
    }
    
    public func endRefreshData() {
        
        if let _ = self.mj_header {
            self.mj_header.endRefreshing();
        }
    }
    
    public func endLoadMoreData() {
        
        if let _ = self.mj_footer {
            self.mj_footer.endRefreshing();
        }
    }
    
    public func loadMoreNoMoreData() {
        
        if let _ = self.mj_footer {
            self.mj_footer.endRefreshingWithNoMoreData();
        }
    }
    
    public func resetNoMoreData() {
        
        if let _ = self.mj_footer {
            self.mj_footer.resetNoMoreData();
        }
    }
    
    open func setRefreshHeaderTitle(_ title: String!, for state: MJRefreshState)
    {
        guard let header: MJRefreshNormalHeader = self.mj_header as? MJRefreshNormalHeader else {
            return;
        }
        header.setTitle(title, for: state);
    }
    
    public func setLoadingStyle(type: WaterViewType) {
        switch type {
        case .kOnlyLoadMore:
            self.mj_footer = loadMoreFooter();
        case .kOnlyRefresh:
            self.mj_header = refreshHeader();
            self.mj_footer = nil;
        case .kRefreshAndLoadMore:
            self.mj_footer = loadMoreFooter();
            self.mj_header = refreshHeader();
        case .kNone:
            self.mj_header = nil;
            self.mj_footer = nil;
        }
    }
    
    public func addRefreshTarget(_ target: Any!, refreshAction action: Selector!) {
        
        if let _ = self.mj_header {
            self.mj_header.setRefreshingTarget(target, refreshingAction: action);
        }
    }
    
    public func addLoadMoreTarget(_ target: Any!, loadMoreAction action: Selector!) {
        
        if let _ = self.mj_footer {
            self.mj_footer.setRefreshingTarget(target, refreshingAction: action);
        }
    }
}
