//
//  SectionViewAdapter.swift
//
//
//  Created by zsf on 2017/1/6.
//  Copyright © 2017年 zsf. All rights reserved.
//

import UIKit

open class SectionTableViewAdapter<SectionItemType, RowItemType>: BaseTableAdapter<RowItemType>, SectionViewAdapterProtocol {
    
    public typealias SItemType = SectionItemType;
    public typealias RItemType = RowItemType;
    
    lazy open var sectionitems = Array<SItemType>();
    
    /// 注册section类型及重用ID
    ///
    /// - parameter headerFooterViewClass: 注册headerFooterViewClass必须继承自ZHBaseTableViewHeaderFooterView
    
    open func registerHeaderFooterCell<HeaderFooterView: BaseTableViewHeaderFooterView<SectionItemType>>(_ headerFooterViewClass: HeaderFooterView.Type) {
        let reuseId = HeaderFooterView.reuseId
        tableView?.register(headerFooterViewClass, forHeaderFooterViewReuseIdentifier: reuseId);
    }
    
    open func reuseIdForHeaderView(_ section: Int) -> String {
        //TODO subclass override this
        return ""
    }
    
    open func reuseIdForFooterView(_ section: Int) -> String {
        //TODO subclass override this
        return ""
    }
    
    open override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowCount(section: section);
    }
    
    open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseId = reuseIdForItem(indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseId) as? BaseTableViewCell<RowItemType>;
        let item = rowItem(row: indexPath.row, section: indexPath.section);
        cell?.delegate = self;
        cell?.fillCell(item: item, indexPath: indexPath);
        return cell!
    }
    
    open override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionItemCount();
    }
    
    override open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let reuseId = reuseIdForHeaderView(section);
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: reuseId) as? BaseTableViewHeaderFooterView<SectionItemType>;
        let item = sectionItem(section: section);
        headerView?.fillHeaderFooterView(item: item, section: section);
        return headerView;
    }
    
    override open func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let reuseId = reuseIdForFooterView(section);
        let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: reuseId) as? BaseTableViewHeaderFooterView<SectionItemType>;
        let item = sectionItem(section: section);
        footerView?.fillHeaderFooterView(item: item, section: section);
        return footerView;
    }
    
    open func rowItems(section: Int) -> Array<RowItemType>? {
        return nil;
    }
    
    public func reloadData() {
        tableView?.reloadData();
    }
}
