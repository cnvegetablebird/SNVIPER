//
//  BaseCollectionAdapter.swift
//  SNVIPER
//
//  Created by zsf on 2017/6/4.
//  Copyright © 2017年 zsf. All rights reserved.
//

import UIKit

open class BaseCollectionAdapter<ItemType>: BaseAdapter, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    weak var _collectionView: UICollectionView?;
    
    open weak var collectionView: UICollectionView? {
        
        get{
            return _collectionView
        }
        set{
            //清除老的配置
            _collectionView?.dataSource = nil
            _collectionView?.delegate = nil
            
            //设置新的配置
            _collectionView = newValue;
            
            _collectionView?.dataSource = self;
            _collectionView?.delegate = self;
            self.registerCell()
        }
    }
    
    /// 注册Cell类型及重用ID
    ///
    /// - parameter cellClass: 注册cell必须继承自BaseCell
    
    open func registerCell<Cell: BaseCollectionViewCell<ItemType>>(_ cellClass: Cell.Type) {
        let reuseId = Cell.reuseId
        collectionView?.register(cellClass, forCellWithReuseIdentifier: reuseId);
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
        
    open func estimatedHeightForCell(_ indexPath: IndexPath) -> CGFloat {
        return 0.0;
    }
    
    open func cellHeightForIndexPath(_ indexPath: IndexPath) -> CGFloat {
        return 0.0;
    }
    
    //MARK: - UICollectionViewDataSource
    //@required
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0;
    }
    
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UICollectionViewCell.className, for: indexPath);
        return cell;
    }

    //MARK: - UICollectionViewDataSource
    //@optional
    open func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 0;
    }
    
    open func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: UICollectionReusableView.className, for: indexPath);
        return view;
    }

    //MARK: - UICollectionViewDelegateFlowLayout
    //@optional
    
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let l = collectionViewLayout as? UICollectionViewFlowLayout {
            return l.itemSize;
        }
        return CGSize(width: 0, height: 0);
    }

    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if let l = collectionViewLayout as? UICollectionViewFlowLayout {
            return l.sectionInset;
        }
        return UIEdgeInsets.zero;
    }

    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if let l = collectionViewLayout as? UICollectionViewFlowLayout {
            return l.minimumLineSpacing;
        }
        return 0.0;
    }
    
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if let l = collectionViewLayout as? UICollectionViewFlowLayout {
            return l.minimumInteritemSpacing;
        }
        return 0.0;
    }
    
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if let l = collectionViewLayout as? UICollectionViewFlowLayout {
            return l.headerReferenceSize;
        }
        return CGSize(width: 0, height: 0);
    }
    
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if let l = collectionViewLayout as? UICollectionViewFlowLayout {
            return l.footerReferenceSize;
        }
        return CGSize(width: 0, height: 0);
    }
    
    //MARK: - UICollectionViewDelegate
    //@optional
    
    open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    open func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
    
    open func reloadData() {
        collectionView?.reloadData();
    }

}
