//
//  Int + Extension.swift
//  client
//
//  Created by 盛子康 on 2021/4/9.
//

public extension Int{
    
    var seconds:TimeInterval{
        return TimeInterval(self / 1000)
    }
    
    var displayTime:String{
        let hour = self / 3600
        let hourRemain = self % 3600
        let minute = hourRemain / 60
        let second = hourRemain % 60
        return "\(hour):\(minute):\(second)"
    }
}
