//
//  UILabel + Extension.swift
//  client
//
//  Created by 盛子康 on 2021/4/12.
//

public extension UILabel{
    
    func setGenericAttributeString(baseText:String,baseAttributes:[NSAttributedString.Key:Any],style:AttributeTextStyle,colorInText:[String]? = nil,forColor:UIColor? = nil,fontInText:[String]? = nil,forFont:UIFont? = nil,imageAttributeString:NSAttributedString? = nil,imageIndex:Int? = nil){
        
        let nsString = NSString(string: baseText)
        
        let attributeString = NSMutableAttributedString(string: baseText, attributes: baseAttributes)
        
        if style.contains(.font){
            guard let texts = fontInText,let font = forFont else{fatalError()}
            for text in texts{
                attributeString.addAttributes([.font:font], range: nsString.range(of: text))
            }
        }
        
        if style.contains(.color){
            guard let texts = colorInText,let color = forColor else{fatalError()}
            for text in texts{
                attributeString.addAttributes([.foregroundColor:color], range: nsString.range(of: text))
            }
        }
        
        if style.contains(.image){
            guard let str = imageAttributeString,let index = imageIndex else{return}
            attributeString.insert(str, at: index)
        }
        
        attributedText = attributeString
    }
}

public struct AttributeTextStyle:OptionSet{
    public var rawValue:UInt8
    
    public init(rawValue: UInt8){
        self.rawValue = rawValue
    }
    
    public static var font = AttributeTextStyle(rawValue: 1 << 0)
    public static var color = AttributeTextStyle(rawValue: 1 << 1)
    public static var image = AttributeTextStyle(rawValue: 1 << 2)
}
