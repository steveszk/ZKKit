//
//  Array + Extenstion.swift
//  Teacher
//
//  Created by edy on 2021/11/9.
//

public extension Array where Element:Hashable{
    var unique:[Element] {
        var uniq = Set<Element>()
        uniq.reserveCapacity(count)
        return filter {
            return uniq.insert($0).inserted
        }
    }
}
