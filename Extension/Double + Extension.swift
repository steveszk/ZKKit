//
//  CGFloat + Extension.swift
//  client
//
//  Created by 盛子康 on 2021/3/30.
//
import UIKit

public extension Double{
    
    var ratio:CGFloat{
        return widthRito * CGFloat(self)
    }
    
    func roundTo(places: Int) -> Double {
        let divisor = pow(10.0,Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    var displayDistance:String{
        if self > 1000{
            return "\((self / 1000).roundTo(places: 2))km"
        }else{
            return "\(ceil(self))m"
        }
    }
}
