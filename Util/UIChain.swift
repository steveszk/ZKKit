//
//  UIChain.swift
//  client
//
//  Created by 盛子康 on 2021/3/30.
//

//import SnapKit

public protocol ViewChainable {}

public extension ViewChainable where Self: UIView{
    /// 配置view
    ///
    /// - Parameter config: 配置closure
    /// - Returns: 返回自己
    @discardableResult
    func config(_ config:(Self) -> Void) -> Self{ //'Self' is only available in a protocol or as the result of a method in a class; did you mean 'UIView'?
        config(self)
        return self
    }
}

public extension UIView: ViewChainable{
    /// 添加subview
    ///
    /// - Parameter toSuperView: 父view
    /// - Returns: 返回自己
    func addTo(toSuperView: UIView) -> Self{
        toSuperView.addSubview(self)
        return self
    }
    
    func insertTo(toSuperView: UIView,index:Int) -> Self{
        toSuperView.insertSubview(self, at: index)
        return self
    }
    
    func insertAbove(toSuperView: UIView,above:UIView) -> Self{
        toSuperView.insertSubview(self, aboveSubview: above)
        return self
    }
    
    func insertBelow(toSuperView:UIView,below:UIView) -> Self{
        toSuperView.insertSubview(self, belowSubview: below)
        return self
    }
    
    func arrangeToStackView(toStackView:UIStackView) -> Self{
        toStackView.addArrangedSubview(self)
        return self
    }
    
    @discardableResult
    /// 布局
    ///
    /// - Parameter snapKitMaker: 布局closure
    /// - Returns: 返回自己
    func layout(snapKitMaker:(ConstraintMaker) -> Void) -> Self{
        snp.makeConstraints { (make) in
            snapKitMaker(make)
        }
        return self
    }
    
    @discardableResult
    /// 更新布局
    ///
    /// - Parameter snapKitMaker: 更新布局bclosure
    /// - Returns: 返回自己
    func updateLayout(snapKitMaker:(ConstraintMaker) -> Void) -> Self{
        snp.updateConstraints { (make) in
            snapKitMaker(make)
        }
        return self
    }
    
    @discardableResult
    func setFrame(frame:CGRect) -> Self{
        self.frame = frame
        return self
    }
    
    @discardableResult
    func setShadow(offset:CGSize,opacity:Float,radius:CGFloat,color:CGColor,path:CGRect?) -> Self{
        layer.shadowColor = color
        layer.shadowOffset = offset
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
        if let rect = path{
            layer.shadowPath = UIBezierPath(rect: rect).cgPath
        }
        return self
    }
}
