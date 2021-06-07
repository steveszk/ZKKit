//
//  UIButton + Extension.swift
//  client
//
//  Created by 盛子康 on 2021/4/23.
//
import Kingfisher

public extension UIButton{
    
    func wait(seconds:Int){
        isEnabled = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(seconds)) {[weak self] in
            self?.isEnabled = true
        }
    }
    
    func setImage(url:String){
        kf.setImage(with: URL(string:url), for: .normal)
    }
}
