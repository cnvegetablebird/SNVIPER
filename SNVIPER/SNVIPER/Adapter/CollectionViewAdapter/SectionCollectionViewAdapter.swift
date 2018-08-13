//
//  SectionCollectionViewAdapter.swift
//  SNVIPER
//
//  Created by zsf on 2017/6/4.
//  Copyright © 2017年 zsf. All rights reserved.
//

import UIKit
import Reusable

open class SectionCollectionViewAdapter<SectionItemType, RowItemType>: BaseCollectionAdapter<RowItemType>,SectionViewAdapterProtocol {

    public typealias SItemType = SectionItemType;
    public typealias RItemType = RowItemType;
    
    open var sectionitems = Array<SItemType>();
    
    open func rowItems(section: Int) -> Array<RowItemType>? {
        return nil;
    }
    
    open func reuseIdForReusableView(_ section: Int,kind: String) -> String {
        //TODO subclass override this
        return ""
    }
    
    /// 注册section类型及重用ID
    ///
    /// - parameter headerFooterViewClass: 注册headerFooterViewClass必须继承自BaseCollectionReusableView
    
    open func registerHeaderFooterCell<HeaderFooterView: BaseCollectionReusableView<SectionItemType>>(_ headerFooterViewClass: HeaderFooterView.Type,forSupplementaryViewOfKind: String) {
        let reuseId = HeaderFooterView.reuseIdentifier;
        self.collectionView?.register(headerFooterViewClass, forSupplementaryViewOfKind: forSupplementaryViewOfKind, withReuseIdentifier: reuseId);
    }
    
    //MARK: - UICollectionViewDataSource
    override open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rowCount(section: section);
    }
    
    override open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let reuseId = reuseIdForItem(indexPath)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseId, for: indexPath) as? BaseCollectionViewCell<RowItemType>;
        let item = rowItem(row: indexPath.row, section: indexPath.section);
        cell?.delegate = self;
        cell?.fillCell(item: item, indexPath: indexPath);
        return cell!
    }
    
    override open func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionItemCount();
    }
    
    override open func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let reuseId = reuseIdForReusableView(indexPath.section,kind: kind);
        let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: reuseId, for: indexPath) as? BaseCollectionReusableView<SectionItemType>;
        let item = sectionItem(section: indexPath.section);
        reusableView?.fillCollectionReusableView(item: item, kind: kind, section: indexPath.section);
        return reusableView!;
    }

}
