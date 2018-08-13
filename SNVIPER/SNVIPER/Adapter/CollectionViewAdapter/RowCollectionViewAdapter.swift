//
//  RowCollectionViewAdapter.swift
//  SNVIPER
//
//  Created by zsf on 2017/6/4.
//  Copyright © 2017年 zsf. All rights reserved.
//

import UIKit

open class RowCollectionViewAdapter<ItemType>: BaseCollectionAdapter<ItemType>, RowViewAdapterProtocol {

    public typealias RowItemType = ItemType;
    lazy open var items = Array<RowItemType>();
        
    open override func cellHeightForIndexPath(_ indexPath: IndexPath) -> CGFloat {
        let item = rowItem(row: indexPath.row);
        let cell: BaseCollectionViewCell<RowItemType>? = self.collectionView?.cellForItem(at: indexPath) as? BaseCollectionViewCell<ItemType>;
        return cell?.heightForData(obj: item) ?? 1.0;
    }
    
    //MARK: - UICollectionViewDataSource
    open override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rowItemCount();
    }
    
    open override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reuseId = reuseIdForItem(indexPath)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseId, for: indexPath) as? BaseCollectionViewCell<RowItemType>;
        let item = rowItem(row: indexPath.row);
        cell?.fillCell(item: item, indexPath: indexPath);
        return cell!;
    }

    open override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 0, height: 0);
    }

}
