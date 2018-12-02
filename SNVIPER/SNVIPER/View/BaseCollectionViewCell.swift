//
//  BaseCollectionViewCell.swift
//  SNVIPER
//
//  Created by zsf on 2017/6/4.
//  Copyright © 2017年 zsf. All rights reserved.
//

import UIKit
import Reusable

/// 可填充协议
public protocol CollectionViewCellFillable {
    associatedtype ItemType;
    func fillCell(item: ItemType?,indexPath: IndexPath?);
}

open class BaseCollectionViewCell<T>: UICollectionViewCell, Reusable, AddViewProtocol, CollectionViewCellFillable{
    
    public typealias ItemType = T;
    
    open var delegate: TouchUpDelegate?;
    
    public override init(frame: CGRect) {
        super.init(frame: frame);
        addSubviews();
        addConstraints();
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func addSubviews() {
        
    }
    
    open func addConstraints() {
        
    }
    
    open func fillCell(item: T?, indexPath: IndexPath?) {
        
    }
    
    /// 取可重用id
    public static var reuseId: String {
        return self.className;
    }
    
    open func heightForData(obj: ItemType) -> CGFloat {
        return 1.0;
    }
}
