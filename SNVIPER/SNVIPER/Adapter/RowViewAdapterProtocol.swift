//
//  RowViewProtocol.swift
//
//
//  Created by zsf on 2017/1/18.
//  Copyright © 2017年 zsf. All rights reserved.
//

import Foundation

public protocol RowViewAdapterProtocol: class {
    
    associatedtype RowItemType;
    
    var items: Array<RowItemType> { set get };
    
    func rowItemCount() -> Int;
    
    // MARK: - add
    func addRowItem(rowItem: RowItemType);
    func addRowItems(rowItems: Array<RowItemType>);
    func addRowItem(rowItem: RowItemType,row: Int);
    func addRowItems(rowItems: Array<RowItemType>,row: Int);
    
    // MARK: - delete
    func removeRowItems(rowItems: Array<RowItemType>);
    func removeRowItem(rowItem: RowItemType);
    func removeRowItemAt(row: Int);
    func removeAllObjects();
    
    // MARK: - update
    func updateRowItem(rowItem: RowItemType);
    
    // MARK: - search
    func rowItem(row: Int) -> RowItemType;
    func rowItemId(rowItem: RowItemType) -> String;//子类实现
    func row(rowItemId: String) -> Int;//子类实现
    
    func reloadData();
}

public extension RowViewAdapterProtocol {
    
    public func rowItemCount() -> Int {
        return items.count;
    }
    
    // MARK: - add
    public func addRowItem(rowItem: RowItemType) {
        items.append(rowItem);
        reloadData();
    }
    
    public func addRowItems(rowItems: Array<RowItemType>) {
        items.append(contentsOf: rowItems);
        reloadData();
    }
    
    public func addRowItem(rowItem: RowItemType,row: Int) {
        items.insert(rowItem, at: row);
        reloadData();
    }
    
    public func addRowItems(rowItems: Array<RowItemType>,row: Int) {
        items.insert(contentsOf: rowItems, at: row);
        reloadData();
    }
    
    // MARK: - delete
    public func removeRowItems(rowItems: Array<RowItemType>) {
        
        for item in rowItems {
            removeRowItem(rowItem: item);
        }
        reloadData();
    }
    
    public func removeRowItem(rowItem: RowItemType) {
        
        let count  = items.count;
        for i in 0..<count {
            let item = items[i];
            let leftItemId = rowItemId(rowItem: item);
            let rightItemId = rowItemId(rowItem: rowItem);
            if leftItemId == rightItemId {
                items.remove(at: i);
                break;
            }
        }
        reloadData();
    }
    
    public func removeRowItemAt(row: Int) {
        items.remove(at: row);
        reloadData();
    }
    
    public func removeAllObjects() {
        items.removeAll();
        reloadData();
    }

    // MARK: - update
    public func updateRowItem(rowItem: RowItemType) {
        
        let count  = items.count;
        for i in 0..<count {
            let item = items[i];
            let leftItemId = rowItemId(rowItem: item);
            let rightItemId = rowItemId(rowItem: rowItem);
            if leftItemId == rightItemId {
                items.remove(at: i);
                items.insert(rowItem, at: i);
                break;
            }
        }
        reloadData();
    }
    
    // MARK: - search
    public func rowItem(row: Int) -> RowItemType {
        return items[row];
    }
    
    public func rowItemId(rowItem: RowItemType) -> String {
        return "";
    }
    
    public func row(rowItemId: String) -> Int {
        return 0;
    }
}
