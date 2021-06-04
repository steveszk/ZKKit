//
//  SZKKitUtil.swift
//  client
//
//  Created by 盛子康 on 2021/6/4.
//
import RxSwift

public struct SZKKitUtil {
    public static func sendTokenInvalidateNotification(){
        NotificationCenter.default.post(name: .tokenInvalidate, object: nil)
    }
    
    public static func generateDisposeBag() -> DisposeBag{
        return DisposeBag()
    }
}

public extension NSNotification.Name{
    static let tokenInvalidate = NSNotification.Name("tokenInvalidate")
}

/// 手机高度
let screenHeight = UIScreen.main.bounds.height
/// 手机宽度
let screenWidth = UIScreen.main.bounds.width

/// 底部安全域高度
let safeBottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0

/// 顶部安全领高度
let safeTop = UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0

/// 安全领frame
let safeFrame = UIApplication.shared.keyWindow?.safeAreaLayoutGuide.layoutFrame ?? .zero

/// 状态栏高度
let statusBarHeight = UIApplication.shared.statusBarFrame.size.height
/// 导航栏高度
let navigationBarHeight = statusBarHeight + 44

/// 屏宽比
let widthRito = screenWidth / 375

/// feedback
let feedback = UINotificationFeedbackGenerator()
