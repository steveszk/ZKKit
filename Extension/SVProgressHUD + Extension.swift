//
//  SVProgressHUD + Extension.swift
//  client
//
//  Created by 盛子康 on 2021/4/13.
//
import SVProgressHUD

public extension SVProgressHUD{
    
    static func normalShow(status:String?){
        DispatchQueue.main.async {
            UIApplication.shared.keyWindow?.isUserInteractionEnabled = false
            SVProgressHUD.setImageViewSize(CGSize(width: 28, height: 28))
            SVProgressHUD.show(withStatus: status)
        }
    }
    
    static func normalDismiss(){
        UIApplication.shared.keyWindow?.isUserInteractionEnabled = true
        SVProgressHUD.dismiss()
        SVProgressHUD.setImageViewSize(CGSize(width: 0, height: -10))
    }
}
