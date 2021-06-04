//
//  Target.swift
//  client
//
//  Created by 盛子康 on 2021/3/30.
//

import Moya
import SVProgressHUD

struct networkPlugin:PluginType {
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var req = request
        req.timeoutInterval = timeout
        return req
    }
    
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        //如果请求未成功，response是未nil，后面的mapper当然也不会执行了。这里拿到Moyaerror中的underlying，转为NScode拿到code码对应。code码和reponse中的statuscode不一样
        if case .failure(let moyaError) = result{
            guard case let .underlying(afError,_) = moyaError else{return}
            guard case let .sessionTaskFailed(urlError) = afError.asAFError else{return}
            switch (urlError as NSError).code{
            case NSURLErrorNotConnectedToInternet:
                feedback.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.error)
                SVProgressHUD.showInfo(withStatus: "网络信号找不到，检查一下吧～")
                LogError(message: "网络信号没有开启")
            case NSURLErrorTimedOut:
                feedback.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.error)
                SVProgressHUD.showInfo(withStatus: "网络不给力～")
                LogError(message: "请求超时")
            case -1004:
                feedback.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.error)
                SVProgressHUD.showInfo(withStatus: "服务器正在维护中～")
                LogError(message: "服务器关闭")
            case -1005:
                feedback.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.error)
                LogError(message: "-1005请求丢失")
            default: //backgroundFetch在后台有机会执行刷新，beginBackgroundTask在进入后台s后延长可执行时间，默认5s
                feedback.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.error)
                SVProgressHUD.showInfo(withStatus: "系统开小差了(\((urlError as NSError).code))～")
                LogError(message: "请求出错,未知错误,unknow")
            }
        }
    }
}

/// 带有svp的插件，会在将要请求的时候show svp，并且禁止window交互，完成后dismiss svp恢复window
//FIXME: 请求还没回来的时候又个弹窗，原window没有恢复交互能力
struct svpPlugin:PluginType {
    
    func willSend(_ request: RequestType, target: TargetType) {
        SVProgressHUD.normalShow(status: "请稍后")
    }
    
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        SVProgressHUD.normalDismiss()
    }
}

/// 正常的provider,带有插件token验证
let normalProvider = MoyaProvider<MultiTarget>(plugins:[networkPlugin()])

/// 带有svp插件和token验证插件的provider，一般用作时间动作较长的操作，如图片上传，为了保证不混乱和意外发生，请求期间window禁止点击。
let svpProvider = MoyaProvider<MultiTarget>(plugins:[svpPlugin(),networkPlugin()])
