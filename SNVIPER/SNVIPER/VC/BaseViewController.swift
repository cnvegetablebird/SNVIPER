//
//  BaseViewController.swift
//  SNVIPER
//
//  Created by zsf on 2017/3/20.
//  Copyright © 2017年 zsf. All rights reserved.
//

import UIKit

open class BaseViewController: UIViewController,AddViewProtocol {

    override open func viewDidLoad() {
        super.viewDidLoad();
        addSubviews();
        addConstraints();
    }
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    open func addSubviews() {
        placeDefaultBackButton();
    }
    
    open func addConstraints() {
        
    }
    
    open func placeDefaultBackButton() {
        if self.isPresented {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem.backBarButtonItem(target: self, action: #selector(onBack), imageName: "nav_btn_close");
        }
        else {
            if self.navigationController?.viewControllers.count ?? 0 > 1 {
                self.navigationItem.leftBarButtonItem = UIBarButtonItem.backBarButtonItem(target: self, action: #selector(onBack), imageName: "nav_btn_back");
            }
        }
    }
    
    @objc open func onBack() {
        if self.isPresented {
            if (self.navigationController == nil && self.presentationController != nil) {
                self.dismiss(animated: true) {
                    
                };
            }
            else if (self.navigationController?.viewControllers.first == self){
                self.navigationController?.dismiss(animated: true, completion: {
                    
                });
            }
        }
        else {
            self.navigationController?.popViewController(animated: true);
        }
    }
}
