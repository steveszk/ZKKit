//
//  UIImageView + Extension.swift
//  client
//
//  Created by 盛子康 on 2021/3/31.
//

import Kingfisher

public extension UIImageView{
    
    func setImageWithPlaceHolder(url:String){
        if image == nil{
            kf.setImage(with: URL(string:url), placeholder: UIImage(named:"placeHolder"), options: [.forceTransition,.transition(.fade(0.2))], progressBlock: nil, completionHandler: {_ in})
        }else{
            kf.setImage(with: URL(string:url), placeholder: UIImage(named:"placeHolder"), options: [.transition(.fade(0.2))], progressBlock: nil, completionHandler: {_ in})
        }
    }
    
    func setImage(url:String){
        kf.setImage(with: URL(string:url))
    }
    
    func setSquareImageWithPlaceHolder(url:String){
        if image == nil{
            kf.setImage(with: URL(string:url), placeholder: UIImage(named:"squarePlaceHolder"), options: [.forceTransition,.transition(.fade(0.2))], progressBlock: nil, completionHandler: {_ in})
        }else{
            kf.setImage(with: URL(string:url), placeholder: UIImage(named:"squarePlaceHolder"), options: [.transition(.fade(0.2))], progressBlock: nil, completionHandler: {_ in})
        }
    }
}
