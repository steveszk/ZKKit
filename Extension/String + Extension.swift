//
//  String + Extension.swift
//  client
//
//  Created by 盛子康 on 2021/3/30.
//
import CommonCrypto

public extension String {
    
    static let notificationActionKey = "notificationActionKey"
    
    /// 用正则表达式验证是否是手机号格式
    var validatePhone:Bool{
        let regex = "^(13[0-9]|14[01456879]|15[0-35-9]|16[2567]|17[0-8]|18[0-9]|19[0-35-9])\\d{8}$"
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
        return count == 6
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
    
    func getHeight(attributes:[NSAttributedString.Key:Any],width:CGFloat) -> CGFloat{
        let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        return ceil(rect.height)
    }
    
    func getWidth(attributes:[NSAttributedString.Key:Any],height:CGFloat) -> CGFloat{
        let rect = NSString(string: self).boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: height), options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        return ceil(rect.width)
    }
    
    //yyyy-MM-dd HH:mm:ss
    func forDate(template:String) -> Date?{
        let f = DateFormatter()
        f.dateFormat = template
        return f.date(from: self)
    }
    
    /// sha256
    var sha256: String{
        let utf8 = cString(using: .utf8)
        var digest = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
        CC_SHA256(utf8, CC_LONG(utf8!.count - 1), &digest)
        return digest.reduce("") { $0 + String(format:"%02x", $1) }
    }
    
    var trimSpace: String{
        trimmingCharacters(in: .whitespaces)
    }
    
    func urlEncoded() -> String? {
        return addingPercentEncoding(withAllowedCharacters:.urlQueryAllowed)
    }
    
    func urlDecoded() -> String? {
        return removingPercentEncoding
    }
}
