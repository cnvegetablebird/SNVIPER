//
//  BaseTableAdapter.swift
//  
//
//  Created by zsf on 2017/1/6.
//  Copyright © 2017年 zsf. All rights reserved.
//

import UIKit
import UITableView_FDTemplateLayoutCell

open class BaseTableAdapter<ItemType>: BaseAdapter,UITableViewDataSource, UITableViewDelegate {
    
    weak var _tableView: UITableView?;
    
    open weak var tableView: UITableView? {
        
        get{
            return _tableView;
        }
        set{
            //清除老的配置
            _tableView?.dataSource = nil;
            _tableView?.delegate = nil;
            
            //设置新的配置
            _tableView = newValue;
            
            _tableView?.dataSource = self;
            _tableView?.delegate = self;
            self.registerCell();
        }
    }
    
    /// 注册Cell类型及重用ID
    ///
    /// - parameter cellClass: 注册cell必须继承自BaseCell
    
    open func registerCell<Cell: BaseTableViewCell<ItemType>>(_ cellClass: Cell.Type) {
        let reuseId = Cell.reuseId
        tableView?.register(cellClass, forCellReuseIdentifier: reuseId);
    }
    
    /// 获取指定位置的Cell 重用ID
    ///
    /// - parameter indexPath: 指定的位置
    ///
    /// - returns: 返回BaseTableViewCell子类的reuseId
    open func reuseIdForItem(_ indexPath: IndexPath) -> String {
        //TODO subclass override this
        return ""
    }
    
    /// 子类需要在这个方法中注册Cell类型
    open func registerCell(){
        
    }
    
    open func tableCellClass(indexPath: IndexPath) -> AnyClass {
        return BaseTableViewCell<ItemType>.self;
    }
    
    open func estimatedHeightForTableViewCell(_ indexPath: IndexPath) -> CGFloat {
        return 0.0;
    }
    
    open func tableCellHeightForIndexPath(_ indexPath: IndexPath) -> CGFloat {
        return 0.0;
    }
    
    // MARK: - UITableViewDataSource
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0;
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell();
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    // MARK: - UITableViewDelegate
    
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let height = estimatedHeightForTableViewCell(indexPath);
        
        if (height > 0.0) {
            // 高度固定
            return CGFloat(height);
        }
        else {
            // 可变高度的，这里做的自动高度缓存
            var cellHei = self.tableView?.fd_indexPathHeightCache.height(for: indexPath) ?? 0.0;
            if cellHei <= CGFloat(0.0) {
                cellHei = tableCellHeightForIndexPath(indexPath);
                self.tableView?.fd_indexPathHeightCache.cacheHeight(cellHei, by: indexPath);
            }
            return cellHei;
        }
    }
    
    open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil;
    }
    
    open func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil;
    }
    
    open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0;
    }
    
    open func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0;
    }
    
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    open func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}
