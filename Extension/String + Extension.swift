//
//  String + Extension.swift
//  client
//
//  Created by 盛子康 on 2021/3/30.
//

public extension String {
    
    static let notificationActionKey = "notificationActionKey"
    
    /// 用正则表达式验证是否是手机号格式
    var validatePhone:Bool{
        let regex = "^((13[0-9])|(14[5,7])|(15[0-3,5-9])|(17[0,3,5-8])|(18[0-9])|166|198|199|(147))\\d{8}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        let isValid = predicate.evaluate(with: self)
        return isValid
    }
    
    /// 用正则表达式验证是否是密码格式：数字和字母组合，8-20位
    var validatePassword:Bool{
        let regex = "^[a-zA-Z0-9]{8,20}+$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        let isValid = predicate.evaluate(with: self)
        return isValid
    }
    
    /// 验证是否是验证码格式，4位数字
    var validateCode:Bool{
        return count == 4
    }
    
    /// 用正则表达式验证是否是用户名
    var validateUsername:Bool{
        let regex = "^[a-zA-Z0-9]{6,20}+$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        let isValid = predicate.evaluate(with: self)
        return isValid
    }
    
    /// 用正则表达式验证是否是邮箱
    var validateEmail:Bool{
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9,-]+\\.[A-Za-z]{2,6}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        let isValid = predicate.evaluate(with: self)
        return isValid
    }
    
    /// 用正则表达式简单验证是否是身份证
    var validateIDCard:Bool{
        let regex = "^(\\d{14}|\\d{17})(\\d|[xX])$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        let isValid = predicate.evaluate(with: self)
        return isValid
    }
    
    var validateAlipayAccount:Bool{
        return self.validatePhone || self.validateEmail
    }
    
    /// 验证是否是银行卡格式：Luhn算法
    var validateBankCard:Bool{
        
        var oddSum = 0     // 奇数和
        var evenSum = 0    // 偶数和
        var allSum = 0    // 总和
        
        // 循环加和
        
        for i in 1...self.count {
            
            let temp = self.suffix(i)
            let theNumber = temp.prefix(1)
            guard Int(theNumber) != nil else {return false}
            var lastNumber = Int(theNumber)!
            if i % 2 == 0{
                // 偶数位
                lastNumber *= 2
                if lastNumber > 9{
                    lastNumber -= 9
                }
                evenSum += lastNumber
            }else{
                // 奇数位
                oddSum += lastNumber
            }
        }
        allSum = oddSum + evenSum
        // 是否合法
        if allSum % 10 == 0{
            return true
        }else{
            return false
        }
    }
    
    /// string转md5
    var md5 : String{
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        
        CC_MD5(str!, strLen, result)
        
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        result.deallocate()
        return String(format: hash as String)
    }
    
    var doubleVaue:Double{
        if let value = Double(self){
            return value
        }else{
            LogError(message: "字符串转double失败")
            return 0.0
        }
    }
    
    var toDictionary:[String:Any]?{
        guard let dataStr = data(using: String.Encoding.utf8) else{return nil}
    
        if let dic = try? JSONSerialization.jsonObject(with: dataStr, options: .mutableContainers) as? [String:Any]{
            return dic
        }else{
            return nil
        }
    }
}
