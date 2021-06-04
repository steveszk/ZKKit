//
//  RxMoyaMapper.swift
//  client
//
//  Created by 盛子康 on 2021/3/30.
//
import RxSwift
import Moya
import ObjectMapper
import SVProgressHUD

public let feedback = UINotificationFeedbackGenerator()

public enum SZKError : Swift.Error {
    // 解析失败
    case ParseJSONError
    // 网络请求发生错误
    case RequestFailed
    //服务器返回了一个错误代码
    case UnexpectedResult(Int)
}

public extension PrimitiveSequence where Trait == SingleTrait, Element == Response{
    
//    func mapResponse<T:Mappable>(type:T.Type) -> Single<T> {
//        return flatMap { response -> Single<T> in
//            return Single.just(try response.mapResponseToObject(type: type))
//        }
//    }
//
//    func mapResponseArray<T:Mappable>(type:T.Type) -> Single<[T]> {
//        return flatMap { response -> Single<[T]> in
//            return Single.just(try response.mapResponseToObjectArray(type: type))
//        }
//    }
    
    func mapEmpty() -> Single<Void> {
        return flatMap { response -> Single<Void> in
            return Single.just(try response.mapResponseToEmpty())
        }
    }
    
//    func mapType<T>(type: T.Type) -> Single<T> {
//        return flatMap { response -> Single<T> in
//            return Single.just(try response.mapResponseToType(type:type))
//        }
//    }
}

extension Response{
//    func mapResponseToObject<T: Mappable>(type: T.Type) throws  -> T {
//
//        guard ((200...209) ~= statusCode) else {
//            feedback.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.error)
//            LogError(message: "服务器出错http code\(statusCode)")
//            SVProgressHUD.showInfo(withStatus: "服务器出了点问题~(\(statusCode))")
//            throw SZKError.RequestFailed
//        }
//
//        guard let json = try? JSONSerialization.jsonObject(with: self.data, options: JSONSerialization.ReadingOptions(rawValue: 0)) as? [String: Any]  else {
//            feedback.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.error)
//            LogError(message: "服务器返回数据非json格式")
//            SVProgressHUD.showInfo(withStatus: "数据解析失败")
//            throw SZKError.ParseJSONError
//        }
//
//        LogDebug(message: json.description)
//
//        if let code = json[SZKKitConfig.codeKey] as? Int {
//
//            if code == SZKKitConfig.tokenInvalidateCode{
//                SZKKitConfig.sendTokenInvalidateNotification()
//            }
//
//            if code == SZKKitConfig.successCode{
//                if let content = json[SZKKitConfig.dataKey],let data = content as? Dictionary<String, Any>{
//
//                    if let object = Mapper<T>().map(JSON: data){
//                        return object
//                    }else{
//                        feedback.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.error)
//                        LogError(message: "后台返回数据匹配失败")
//                        SVProgressHUD.showInfo(withStatus: "数据解析失败")
//                        throw SZKError.ParseJSONError
//                    }
//                }else{
//                    feedback.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.error)
//                    LogError(message: "后台返回数据转dictionary失败")
//                    SVProgressHUD.showInfo(withStatus: "数据解析失败")
//                    throw SZKError.ParseJSONError
//                }
//            } else {
//                feedback.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.error)
//                LogError(message: "预期错误，code：\(code),msg:\(json[SZKKitConfig.messageKey] as? String ?? "")")
//                SVProgressHUD.showInfo(withStatus: json[SZKKitConfig.messageKey] as? String)
//                throw SZKError.UnexpectedResult(code)
//            }
//        } else {
//            feedback.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.error)
//            LogError(message: "服务器返回code码非整形")
//            SVProgressHUD.showInfo(withStatus: "数据解析失败")
//            throw SZKError.ParseJSONError
//        }
//    }
//
//    func mapResponseToObjectArray<T: Mappable>(type: T.Type) throws  -> [T] {
//
//        guard ((200...209) ~= statusCode) else {
//            feedback.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.error)
//            LogError(message: "服务器出错http code\(statusCode)")
//            SVProgressHUD.showInfo(withStatus: "服务器出了点问题~(\(statusCode))")
//            throw SZKError.RequestFailed
//        }
//
//        guard let json = try? JSONSerialization.jsonObject(with: self.data, options: JSONSerialization.ReadingOptions(rawValue: 0)) as? [String: Any]  else {
//            feedback.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.error)
//            LogError(message: "服务器返回数据非json格式")
//            SVProgressHUD.showInfo(withStatus: "数据解析失败")
//            throw SZKError.ParseJSONError
//        }
//
//        LogDebug(message: json.description)
//
//        if let code = json[SZKKitConfig.codeKey] as? Int {
//
//            if code == SZKKitConfig.tokenInvalidateCode{
//                SZKKitConfig.sendTokenInvalidateNotification()
//            }
//
//            if code == SZKKitConfig.successCode{
//                if let content = json[SZKKitConfig.dataKey],let data = content as? [Dictionary<String, Any>]{
//                    return Mapper<T>().mapArray(JSONArray: data)
//                }else{
//                    feedback.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.error)
//                    LogError(message: "后台返回数据转dictionary数组失败")
//                    SVProgressHUD.showInfo(withStatus: "数据解析失败")
//                    throw SZKError.ParseJSONError
//                }
//            } else {
//                feedback.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.error)
//                LogError(message: "预期错误，code：\(code),msg:\(json[SZKKitConfig.messageKey] as? String ?? "")")
//                SVProgressHUD.showInfo(withStatus: json[SZKKitConfig.messageKey] as? String)
//                throw SZKError.UnexpectedResult(code)
//            }
//        } else {
//            feedback.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.error)
//            LogError(message: "服务器返回code码非整形")
//            SVProgressHUD.showInfo(withStatus: "数据解析失败")
//            throw SZKError.ParseJSONError
//        }
//    }
//
    func mapResponseToEmpty() throws  -> Void{
        
        guard ((200...209) ~= statusCode) else {
            feedback.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.error)
            LogError(message: "服务器出错http code\(statusCode)")
            SVProgressHUD.showInfo(withStatus: "服务器出了点问题~(\(statusCode))")
            throw SZKError.RequestFailed
        }
        
//        guard let json = try? JSONSerialization.jsonObject(with: self.data, options: JSONSerialization.ReadingOptions(rawValue: 0)) as? [String: Any]  else {
//            feedback.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.error)
//            LogError(message: "服务器返回数据非json格式")
//            SVProgressHUD.showInfo(withStatus: "数据解析失败")
//            throw SZKError.ParseJSONError
//        }
        let json = [String:Any]()
        LogDebug(message: json.description)
        
        if let code = json[SZKKitConfig.codeKey] as? Int {
            
            if code == SZKKitConfig.tokenInvalidateCode{
                SZKKitConfig.sendTokenInvalidateNotification()
            }
        
            guard code == SZKKitConfig.successCode else {
                feedback.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.error)
                LogError(message: "预期错误，code：\(code),msg:\(json[SZKKitConfig.messageKey] as? String ?? "")")
                SVProgressHUD.showInfo(withStatus: json[SZKKitConfig.messageKey] as? String)
                throw SZKError.UnexpectedResult(code)
            }
        } else {
            feedback.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.error)
            LogError(message: "服务器返回code码非整形")
            SVProgressHUD.showInfo(withStatus: "数据解析失败")
            throw SZKError.ParseJSONError
        }
    }
    
//    func mapResponseToType<T>(type: T.Type) throws  -> T{
//
//        guard ((200...209) ~= statusCode) else {
//            feedback.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.error)
//            LogError(message: "服务器出错http code\(statusCode)")
//            SVProgressHUD.showInfo(withStatus: "服务器出了点问题~(\(statusCode))")
//            throw SZKError.RequestFailed
//        }
//
//        guard let json = try? JSONSerialization.jsonObject(with: self.data, options: JSONSerialization.ReadingOptions(rawValue: 0)) as? [String: Any]  else {
//            feedback.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.error)
//            LogError(message: "服务器返回数据非json格式")
//            SVProgressHUD.showInfo(withStatus: "数据解析失败")
//            throw SZKError.ParseJSONError
//        }
//
//        LogDebug(message: json.description)
//
//        if let code = json[SZKKitConfig.codeKey] as? Int {
//
//            if code == SZKKitConfig.tokenInvalidateCode{
//                SZKKitConfig.sendTokenInvalidateNotification()
//            }
//
//            if code == SZKKitConfig.successCode {
//                if let content = json[SZKKitConfig.dataKey],let data = content as? T{
//                    return data
//                }else{
//                    feedback.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.error)
//                    LogError(message: "后台返回数据非指定数据类型")
//                    SVProgressHUD.showInfo(withStatus: "数据解析失败")
//                    throw SZKError.ParseJSONError
//                }
//            }else {
//                feedback.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.error)
//                LogError(message: "预期错误，code：\(code),msg:\(json[SZKKitConfig.messageKey] as? String ?? "")")
//                SVProgressHUD.showInfo(withStatus: json[SZKKitConfig.messageKey] as? String)
//                throw SZKError.UnexpectedResult(code)
//            }
//        } else {
//            feedback.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.error)
//            LogError(message: "服务器返回code码非整形")
//            SVProgressHUD.showInfo(withStatus: "数据解析失败")
//            throw SZKError.ParseJSONError
//        }
//    }
}
