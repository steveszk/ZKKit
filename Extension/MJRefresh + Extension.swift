//
//  MJRefresh + Extension.swift
//  Teacher
//
//  Created by edy on 2021/11/12.
//
import MJRefresh

public extension MJRefreshBackNormalFooter{
    
    convenience init(bottomInset:CGFloat){
        self.init()
        ignoredScrollViewContentInsetBottom = bottomInset
    }
}

public extension MJRefreshNormalHeader{
    
    convenience init(topInset:CGFloat){
        self.init()
        ignoredScrollViewContentInsetTop = topInset
    }
}
