//
//  UIFont + Extension.swift
//  client
//
//  Created by 盛子康 on 2021/3/30.
//

import UIKit

public extension UIFont{
    
    /// 获取常规平方字体。默认14号//9-13 10-14 11-15.5 12-17 13-18.5 14-20 15-21 16-22.5 17-24 18-25.5 19-27 20-28
    ///
    /// - Parameter size: 字体号
    /// - Returns: 常规平方字体
    static func regular(size:CGFloat = 14) -> UIFont{
        return UIFont(name: "PingFangSC-Regular", size: size)!
    }
    
    /// 获取加粗平方字体，默认14号
    ///
    /// - Parameter size: 字体号
    /// - Returns: 中号平方字体
    static func bold(size:CGFloat = 14) -> UIFont{
        return UIFont(name: "PingFangSC-Semibold", size: size)!
    }
    
    /// 获取加粗平方字体，默认14号
    ///
    /// - Parameter size: 字体号
    /// - Returns: 中号平方字体
    static func medium(size:CGFloat = 14) -> UIFont{
        return UIFont(name: "PingFangSC-Medium", size: size)!
    }
    
    /// 获取DINPro字体，默认14号，在info.plist中添加Fonts provided by application ：DINPro-Medium.otf
    ///
    /// - Parameter size: 字体号
    /// - Returns: 中号平方字体
//    static func din(size:CGFloat = 14) -> UIFont{
//        return UIFont(name: "DINPro-Medium", size: size)!
//    }
}
