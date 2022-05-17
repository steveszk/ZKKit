//
//  JJTextView.swift
//  Teacher
//
//  Created by edy on 2022/1/7.
//

import UIKit

public class PlaceHolderTextView: UITextView {

    let textPlaceHolder = UILabel()
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
    
        textContainerInset = UIEdgeInsets(top: 8, left: 11, bottom: 8, right: 11)
        showsVerticalScrollIndicator = false
        delegate = self
        
        textPlaceHolder.addTo(toSuperView: self).layout { make in
            make.leading.equalTo(self).offset(16)
            make.top.equalTo(self).offset(8)
        }
    }
    
    func setText(value:String?){
        if let v = value,v != ""{
            text = v
            textPlaceHolder.isHidden = true
        }else{
            textPlaceHolder.isHidden = false
        }
    }
}

public extension PlaceHolderTextView: UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        textPlaceHolder.isHidden = textView.text != ""
    }
}

