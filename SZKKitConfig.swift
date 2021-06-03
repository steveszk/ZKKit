//
//  SZKKitConfig.swift
//  client
//
//  Created by 盛子康 on 2021/6/3.
//
import CocoaLumberjack
import IQKeyboardManagerSwift
import SVProgressHUD
import Kingfisher

public struct SZKKitConfig {
    
    public static func configPods(){
        
        //DDLog
        //日志，debug打印所有，release不打印,file的loger先不打印,只打印控制台,可以自定义loger和manager，也可以改变文件的位置，让其可见而不是cache里。
        #if DEBUG
        //        let file = DDFileLogger()
        //        file?.rollingFrequency = 60*60*24
        //        file?.logFileManager.maximumNumberOfLogFiles = 7
        //        DDLog.add(file!)
        dynamicLogLevel = .verbose
        let console = DDTTYLogger.sharedInstance
        console?.logFormatter = logFormatter()
        DDLog.add(console!)
        #else
        dynamicLogLevel = .off
        #endif
        
        //键盘设置
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        
        //加载框
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.dark) //背景色黑色
        SVProgressHUD.setMinimumDismissTimeInterval(1.5) //最短消失时间
        SVProgressHUD.setImageViewSize(CGSize(width: 0, height: -10))
        
        //图片加载
        KingfisherManager.shared.downloader.downloadTimeout = 10
        KingfisherManager.shared.cache.diskStorage.config.expiration = .days(5)
    }
}
