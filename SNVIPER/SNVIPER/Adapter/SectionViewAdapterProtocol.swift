//
//  SectionViewProtocol.swift
//
//
//  Created by zsf on 2017/1/18.
//  Copyright © 2017年 zsf. All rights reserved.
//

import Foundation

public protocol SectionViewAdapterProtocol: class {
    
    associatedtype SItemType;
    associatedtype RItemType;
    
    var sectionitems: Array<SItemType> { set get };
    
    func sectionItemCount() -> Int;
    
    // MARK: - add
    func addSectionItem(sectionItem: SItemType);
    func addSectionItems(sectionItems: Array<SItemType>);
    func addSectionItem(sectionItem: SItemType,row: Int);
    func addRowItems(sectionItems: Array<SItemType>,row: Int);
    
    // MARK: - delete
    func removeSectionItems(sectionItems: Array<SItemType>);
    func removeSectionItem(section: Int);
    func removeAllObjects();
    
    // MARK: - update
    func updateSectionItem(sectionItem: SItemType);
    
    // MARK: -search
    func sectionItem(section: Int) -> SItemType
    func sectionItemId(sectionItem: SItemType) -> String;
    func section(sectionItemId: String) -> Int;
    func sectionItems() -> Array<SItemType>;
    
    func rowCount(section: Int) -> Int;
    func rowItem(row: Int, section: Int) -> RItemType?;
    func rowItems(section: Int) -> Array<RItemType>?;
    
    func reloadData();
}

public extension SectionViewAdapterProtocol {
    
    public func sectionItemCount() -> Int {
        return sectionitems.count;
    }
    
    // MARK: - add
    public func addSectionItem(sectionItem: SItemType) {
        sectionitems.append(sectionItem);
        reloadData()
    }
    
    public func addSectionItems(sectionItems: Array<SItemType>) {
        sectionitems.append(contentsOf: sectionItems);
        reloadData()
    }
    
    public func addSectionItem(sectionItem: SItemType,row: Int) {
        sectionitems.insert(sectionItem, at: row);
        reloadData()
    }
    
    public func addRowItems(sectionItems: Array<SItemType>,row: Int) {
        sectionitems.insert(contentsOf: sectionItems, at: row);
        reloadData()
    }
    
    // MARK: - delete
    public func removeSectionItems(sectionItems: Array<SItemType>) {
        reloadData()
    }
    
    public func removeSectionItem(section: Int) {
        sectionitems.remove(at: section);
        reloadData()
    }
    
    public func removeAllObjects() {
        sectionitems.removeAll();
        reloadData()
    }
    
    // MARK: - update
    public func updateSectionItem(sectionItem: SItemType) {
        reloadData()
    }
    
    // MARK: -search
    public func sectionItem(section: Int) -> SItemType {
        return sectionitems[section];
    }
    
    public func sectionItemId(sectionItem: SItemType) -> String {
        return "";
    }
    
    public func section(sectionItemId: String) -> Int {
        return 0;
    }
    
    public func sectionItems() -> Array<SItemType> {
        return self.sectionitems;
    }
    
    public func rowItem(row: Int, section: Int) -> RItemType? {
        let rows = self.rowItems(section: section);
        
        guard let rowItems = rows else {
            return nil;
        }
        
        if row < rowItems.count {
            return rowItems[row];
        }
        return nil;
    }
    
    public func rowCount(section: Int) -> Int {
        let rows = rowItems(section:section);
        return rows?.count ?? 0;
    }
}
