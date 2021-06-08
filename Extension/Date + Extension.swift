//
//  Date + Extension.swift
//  Client
//
//  Created by 盛子康 on 2020/12/24.
//

public extension Date{
    
    var dateStringByGenericPattern:String {
        let f = DateFormatter()
        f.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return f.string(from: self)
    }
    
    var dateStringByYearMonthDayPattern:String {
        let f = DateFormatter()
        f.dateFormat = "yyyy年MM月dd日"
        return f.string(from: self)
    }
    
    var dateStringByMonthDayPattern:String{
        let f = DateFormatter()
        f.dateFormat = "MM月dd日"
        return f.string(from: self)
    }
    
    var dateStringByYearMonthPattern:String{
        let f = DateFormatter()
        f.dateFormat = "yyyy年MM月"
        return f.string(from: self)
    }
    
    var day:Int{
        return Calendar.current.component(.day, from: self)
    }
    
    var month:Int{
        return Calendar.current.component(.month, from: self)
    }
    
    var year:Int{
        return Calendar.current.component(.year, from: self)
    }
}
