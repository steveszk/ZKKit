//
//  SZKKitUtil.swift
//  client
//
//  Created by 盛子康 on 2021/6/4.
//
import RxSwift
import StoreKit

public struct SZKKitUtil {
    public static func sendTokenInvalidateNotification(){
        NotificationCenter.default.post(name: .tokenInvalidate, object: nil)
    }
    
    public static func generateDisposeBag() -> DisposeBag{
        return DisposeBag()
    }
    
    public static func getIPAddress() -> String?{
        var addresses = [String]()

        var ifaddr : UnsafeMutablePointer<ifaddrs>? = nil
        if getifaddrs(&ifaddr) == 0 {
            var ptr = ifaddr
            while (ptr != nil) {
                let flags = Int32(ptr!.pointee.ifa_flags)
                var addr = ptr!.pointee.ifa_addr.pointee
                if (flags & (IFF_UP|IFF_RUNNING|IFF_LOOPBACK)) == (IFF_UP|IFF_RUNNING) {
                    if addr.sa_family == UInt8(AF_INET) || addr.sa_family == UInt8(AF_INET6) {
                        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                        if (getnameinfo(&addr, socklen_t(addr.sa_len), &hostname, socklen_t(hostname.count),nil, socklen_t(0), NI_NUMERICHOST) == 0) {
                            if let address = String(validatingUTF8:hostname) {
                                addresses.append(address)
                            }
                        }
                    }
                }
                ptr = ptr!.pointee.ifa_next
            }
            freeifaddrs(ifaddr)
        }
        return addresses.first
    }
    
    public static func getAPPVersion() -> String{
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String{
            return version
        }else{
            return "0.0.0"
        }
    }
    
    public static func generateUUID() -> String{
        return UUID().uuidString
    }
    
    public static func generateRandomString(length:Int) -> String{
        let characters = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        var ranStr = ""
        for _ in 0..<length{
            let index = Int(arc4random_uniform(UInt32(characters.count)))
            ranStr.append(characters[characters.index(characters.startIndex, offsetBy: index)])
        }
        return ranStr
    }
    
    public static func alertAPPStoreReview(){
        SKStoreReviewController.requestReview()
    }
}

public extension NSNotification.Name{
    static let tokenInvalidate = NSNotification.Name("tokenInvalidate")
}

/// 手机高度
public let screenHeight = UIScreen.main.bounds.height
/// 手机宽度
public let screenWidth = UIScreen.main.bounds.width

/// 底部安全域高度
public let safeBottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0

/// 顶部安全领高度
public let safeTop = UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0

/// 安全领frame
public let safeFrame = UIApplication.shared.keyWindow?.safeAreaLayoutGuide.layoutFrame ?? .zero

/// 状态栏高度
public let statusBarHeight = UIApplication.shared.statusBarFrame.size.height
/// 导航栏高度
public let navigationBarHeight = statusBarHeight + 44

/// 屏宽比
public let widthRito = screenWidth / 375
//  屏高比
public let heightRito = screenHeight / 667

/// feedback
public let feedback = UINotificationFeedbackGenerator()
