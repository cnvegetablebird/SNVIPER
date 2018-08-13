//
//  BaseCollectionReusableView.swift
//  SNVIPER
//
//  Created by zsf on 2018/1/19.
//  Copyright © 2018年 zsf. All rights reserved.
//

import UIKit
import Reusable

public protocol CollectionReusableViewFillable {
    
    associatedtype ItemType;
    func fillCollectionReusableView(item: ItemType?, kind: String, section: Int);
}

open class BaseCollectionReusableView<T>: UICollectionReusableView, Reusable, AddViewProtocol, CollectionReusableViewFillable{
    
    public typealias ItemType = T;
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews();
        addConstraints();
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func fillCollectionReusableView(item: ItemType?, kind: String, section: Int) {
        
    }
    
    open func addSubviews() {
        
    }
    
    open func addConstraints() {
        
    }
}
