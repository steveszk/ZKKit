//
//  Date + Extension.swift
//  Client
//
//  Created by 盛子康 on 2020/12/24.
//

public extension Date{
    
    var day:Int{
        return Calendar.current.component(.day, from: self)
    }
    
    var month:Int{
        return Calendar.current.component(.month, from: self)
    }
    
    var year:Int{
        return Calendar.current.component(.year, from: self)
    }
    
    var week:Int{
        return Calendar.current.component(.weekday, from: self)
    }
    
    //yyyy-MM-dd HH:mm:ss
    func forDateString(template:String) -> String{
        let f = DateFormatter()
        f.dateFormat = template
        return f.string(from: self)
    }
    
    var timeIntervalString: String{
        return String(timeIntervalSince1970)
    }
}
