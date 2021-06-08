//
//  PaddingLabel.swift
//  customer
//
//  Created by 盛子康 on 2019/8/16.
//  Copyright © 2019 盛子康. All rights reserved.
//

import UIKit

public class PaddingLabel: UILabel {
    
    public var textInsets:UIEdgeInsets = .zero
    
    public override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInsets))
    }
    
    public override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let insets = textInsets
        var rect = super.textRect(forBounds: bounds.inset(by: insets),
                                  limitedToNumberOfLines: numberOfLines)
        
        rect.origin.x -= insets.left
        rect.origin.y -= insets.top
        rect.size.width += (insets.left + insets.right)
        rect.size.height += (insets.top + insets.bottom)
        return rect
    }
}
