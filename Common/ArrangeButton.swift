//
//  ArrangeButton.swift
//  client
//
//  Created by 盛子康 on 2021/4/9.
//

import UIKit

public class ArrangeButton: UIButton {

    public var type = ArrangeButtonType.topImage
    public var margin:CGFloat = 0.0
    
    public func setArrangeType(type:ArrangeButtonType,margin:CGFloat){
        self.type = type
        self.margin = margin
    }
    //这个方法是执行在button已经布局好了之后的，因为button默认是左右，所以如果title加image左右布局超过了button的frame，那么title的宽度就会默认减小所以有时候现实不全，可以手动计算文字宽度重新设置宽度，这个问题只会在上下布局出现，左右的时候label只要设置buttonframe没问题就不会减小，至于margin，设置了margin的话可能会超出frame但是没事。
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let imageSize = imageView?.frame.size,let titleSize = titleLabel?.frame.size else{return}
        
        switch type {
        case .topImage:
            let totalHeight = imageSize.height + titleSize.height + margin
            let totalMarginY = (frame.size.height - totalHeight) / 2
            let imageX = frame.size.width / 2 - imageSize.width / 2
            imageView?.frame.origin = CGPoint(x: imageX, y: totalMarginY)
            let titleY = frame.size.height - totalMarginY - titleSize.height
            titleLabel?.frame = CGRect(x: 0, y: titleY, width: frame.width, height: titleSize.height)
            titleLabel?.textAlignment = .center
        case .rightImage:
            let totalWidth = imageSize.width + titleSize.width + margin
            let totalMarginX = (frame.size.width - totalWidth) / 2
            let titleY = frame.size.height / 2 - titleSize.height / 2
            titleLabel?.frame.origin = CGPoint(x: totalMarginX, y: titleY)
            let imageX = frame.size.width - totalMarginX - imageSize.width
            let imageY = frame.size.height / 2 - imageSize.height / 2
            imageView?.frame.origin = CGPoint(x: imageX, y: imageY)
        case .bottomImage:
            let totalHeight = imageSize.height + titleSize.height + margin
            let totalMarginY = (frame.size.height - totalHeight) / 2
            titleLabel?.frame = CGRect(x: 0, y: totalMarginY, width: frame.width, height: titleSize.height)
            titleLabel?.textAlignment = .center
            let imageX = frame.size.width / 2 - imageSize.width / 2
            let imageY = frame.size.height - totalMarginY - imageSize.height
            imageView?.frame.origin = CGPoint(x: imageX, y: imageY)
        case .leftImage:
            let totalWidth = imageSize.width + titleSize.width + margin
            let totalMarginX = (frame.size.width - totalWidth) / 2
            let imageY = frame.size.height / 2 - imageSize.height / 2
            imageView?.frame.origin = CGPoint(x: totalMarginX, y: imageY)
            let titleX = frame.size.width - totalMarginX - titleSize.width
            let titleY = frame.size.height / 2 - titleSize.height / 2
            titleLabel?.frame.origin = CGPoint(x: titleX, y: titleY)
        }
    }
}

public enum ArrangeButtonType {
    case topImage
    case rightImage
    case bottomImage
    case leftImage
}
