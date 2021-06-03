//
//  APPLog.swift
//  client
//
//  Created by 盛子康 on 2021/3/30.
//

import CocoaLumberjack

class logFormatter:NSObject, DDLogFormatter{
    func format(message logMessage: DDLogMessage) -> String? {
        var logLevel:String
        switch logMessage.flag {
        case DDLogFlag.error:
            logLevel = "❎❎❎❎❎❎❎❎❎❎❎❎❎❎❎❎❎❎"
            break
        case DDLogFlag.warning:
            logLevel = "⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️"
            break
        case DDLogFlag.info:
            logLevel = "✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅"
            break
        case DDLogFlag.debug:
            logLevel = "🛠🛠🛠🛠🛠🛠🛠🛠🛠🛠🛠🛠🛠🛠🛠🛠🛠🛠"
            break
        default:
            logLevel = "❓❓❓❓❓❓❓❓❓❓❓❓❓❓❓❓❓❓"
            break
        }
        
        return logLevel + logMessage.message
    }
}
/**
 得到输出的字符串的格式
 
 - parameter message:  日志消息的主题
 - parameter file:     日志消息所在的文件，方便调试定位用
 - parameter function: 日志消息所在的方法，方便调试定位用
 - parameter line:     日志消息所在的方法中的行数，方便调试定位用
 
 - returns: 返回输出的日志字符串
 */
private func getMessage(message: String, file: StaticString , function: StaticString , line: UInt ) -> String {
    //初始化需要返回的字符串
    var returnMessage:String = ""
    //通过file获取文件的名称
    
    if let className = String(describing: file).components(separatedBy: "/").last {
        //拼接字符串
        returnMessage = "\n" +
            "className:\(className)\n" +
            " function:\(function)\n" +
            "      ine:\(line)\n" +
        "  message:\(message)"
    }else {
        //拼接字符串
        returnMessage = "\n" +
            " function:\(function)\n" +
            "      ine:\(line)\n" +
        "  message:\(message)"
    }
    return returnMessage
}

/**
 输出Info等级的日志消息
 */
public func LogInfo(message: String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
    DDLogInfo(getMessage(message: message, file: file, function: function, line: line))
}

/**
 输出Error等级的日志消息
 */
public func LogError(message: String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
    DDLogError(getMessage(message: message, file: file, function: function, line: line))
}

/**
 输出Debug等级的日志消息
 */
public func LogDebug(message: String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
    DDLogDebug(getMessage(message: message, file: file, function: function, line: line))
}

/**
 输出Warn等级的日志消息
 */
public func LogWarn(message: String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
    DDLogWarn(getMessage(message: message, file: file, function: function, line: line))
}
