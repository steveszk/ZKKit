//
//  JJSegmentedTitleBackgroundCell.swift
//  Teacher
//
//  Created by edy on 2022/4/1.
//

import UIKit

class SegmentedTitleBackgroundCell: JXSegmentedTitleCell {

    let backgroundColorView = UIView()
    
    open override func commonInit() {
        super.commonInit()
        backgroundColorView.layer.cornerRadius = 14
        backgroundColorView.backgroundColor = #colorLiteral(red: 0.964615047, green: 0.9647535682, blue: 0.9645832181, alpha: 1)
        contentView.insertSubview(backgroundColorView, belowSubview: titleLabel)
    }

    open override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColorView.bounds = CGRect(x: 0, y: 0, width: titleLabel.bounds.width + 30, height: 28)
        backgroundColorView.center = contentView.center
    }
    //如果把颜色和边距大小什么的放进itemmodel里，每次reload都要去做颜色大小圆角的事，所以索性直接写死，如果其他地方需要用这个，就把属性放进model中每次去刷新
    override func reloadData(itemModel: JXSegmentedBaseItemModel, selectedType: JXSegmentedViewItemSelectedType) {
        super.reloadData(itemModel: itemModel, selectedType: selectedType)

        backgroundColorView.isHidden = itemModel.isSelected
    }
}
