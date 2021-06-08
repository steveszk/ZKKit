//
//  UIView + Extension.swift
//  Client
//
//  Created by 盛子康 on 2021/1/5.
//

extension UIView{
    
    //在update后调用执行动画
    public func updateConstrainsAnimate(duration:Double,completion:((Bool) -> Void)?){
        needsUpdateConstraints()
        updateConstraintsIfNeeded()
        UIView.animate(withDuration: duration, animations: {
            self.layoutIfNeeded()
        }, completion: completion)
    }
}
