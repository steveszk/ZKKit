//
//  UITextField + Extension.swift
//  Client
//
//  Created by 盛子康 on 2020/12/22.
//

import UIKit

public extension UITextField{
    func setLeftPadding(value:CGFloat){
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: value, height: 0))
        leftViewMode = .always
    }
}
