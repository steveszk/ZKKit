//
//  UIBarButton + Extension.swift
//  Teacher
//
//  Created by edy on 2021/11/18.
//
import UIKit

public extension UIBarButtonItem{
    func wait(seconds:Int){
        isEnabled = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(seconds)) {[weak self] in
            self?.isEnabled = true
        }
    }
}
