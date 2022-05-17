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
    
    var remainGenericTime:String{
        let hour = self / 3600
        let hourRemain = self % 3600
        let minute = hourRemain / 60
        let second = hourRemain % 60
        return "\(hour):\(minute):\(second)"
    }
    
    var remainDisplayTime:String{
        if self < 60{
            return "\(self)秒"
        }else if self >= 60 && self < 60 * 60{
            return "\(self / 60)分钟"
        }else{
            return "\(self / 60 / 60)小时"
        }
    }
    
    var timeInterval:TimeInterval{
        TimeInterval(self)
    }
    
    var km:Double{
        return Double(String(format:"%.2f",CGFloat(self) / 1000.0))!
    }
    
    var chinese:String{
        switch self {
        case 0:
            return "零"
        case 1:
            return "一"
        case 2:
            return "二"
        case 3:
            return "三"
        case 4:
            return "四"
        case 5:
            return "五"
        case 6:
            return "六"
        case 7:
            return "七"
        case 8:
            return "八"
        case 9:
            return "九"
        case 10:
            return "十"
        case 11:
            return "十一"
        case 12:
            return "十二"
        default:
            return ""
        }
    }
    
    var weekDay:String{
        switch self {
        case 0:
            return "星期六"
        case 1:
            return "星期天"
        case 2:
            return "星期一"
        case 3:
            return "星期二"
        case 4:
            return "星期三"
        case 5:
            return "星期四"
        case 6:
            return "星期五"
        case 7:
            return "星期六"
        default:
            return ""
        }
    }
}
