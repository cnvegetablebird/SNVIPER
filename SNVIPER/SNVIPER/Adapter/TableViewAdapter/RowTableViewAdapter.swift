//
//  RowTableViewAdapter.swift
//  
//
//  Created by zsf on 2017/1/6.
//  Copyright © 2017年 zsf. All rights reserved.
//

import UIKit

open class RowTableViewAdapter<ItemType>: BaseTableAdapter<ItemType>,RowViewAdapterProtocol {
    
    public typealias RowItemType = ItemType;
    lazy open var items = Array<RowItemType>();
        
    open override func tableCellHeightForIndexPath(_ indexPath: IndexPath) -> CGFloat {
        let item = rowItem(row: indexPath.row);
        let cellClass: AnyClass = tableCellClass(indexPath: indexPath);
        let cellType: BaseTableViewCell<RowItemType>.Type? = cellClass as? BaseTableViewCell<RowItemType>.Type;
        return cellType?.heightForData(obj: item) ?? 1.0;
    }

    open override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowItemCount();
    }
    
    open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseId = reuseIdForItem(indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseId) as? BaseTableViewCell<RowItemType>;
        let item = rowItem(row: indexPath.row);
        cell?.delegate = self;
        cell?.fillCell(item: item, indexPath: indexPath);
        return cell!
    }

    open override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.touchUpInside(cell: nil, action: nil, object: rowItem(row: indexPath.row), indexPath: indexPath);
    }
    
    public func reloadData() {
        tableView?.reloadData();
    }
}
