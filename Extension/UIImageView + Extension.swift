//
//  UIImageView + Extension.swift
//  client
//
//  Created by 盛子康 on 2021/3/31.
//

import Kingfisher

public extension UIImageView{
    //因为cell的复用问题，如果根据image是否为niu来执行强制动画的话，那么可能出现用户看起来图片已经存在的时候去刷新，而复用了一个cell image为nil却执行了动画
    func setImageWithPlaceHolder(url:String?,placeHolder:PlaceHolderType,forceAnimate:Bool = true,completionClosure:((Result<RetrieveImageResult,KingfisherError>) -> Void)? = nil){
        if let url = url{
            if forceAnimate && image == nil{
                kf.setImage(with: URL(string:url), placeholder: UIImage(named:placeHolder.placeHolderName), options: [.forceTransition,.transition(.fade(0.2))], progressBlock: nil, completionHandler: completionClosure)
            }else{
                kf.setImage(with: URL(string:url), placeholder: UIImage(named:placeHolder.placeHolderName), options: [.transition(.fade(0.2))], progressBlock: nil, completionHandler: completionClosure)
            }
        }else{
            image = UIImage(named: placeHolder.placeHolderName)
        }
    }
    
    func setImage(url:String?,placeHolder:PlaceHolderType){
        if let url = url{
            kf.setImage(with: URL(string:url))
        }else{
            image = UIImage(named: placeHolder.placeHolderName)
        }
    }
}

public enum PlaceHolderType{
    case normal
    case horizontal
    case vertical
    
    var placeHolderName:String{
        switch self{
        case .normal:
            return "normalPlaceHolder"
        case .horizontal:
            return "horizontalPlaceHolder"
        case .vertical:
            return "verticalPlaceHolder"
        }
    }
}
