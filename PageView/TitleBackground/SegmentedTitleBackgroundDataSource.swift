//
//  JJSegmentedTitleBackgroundDataSource.swift
//  Teacher
//
//  Created by edy on 2022/4/1.
//

class SegmentedTitleBackgroundDataSource: JXSegmentedTitleDataSource{
    
    override func registerCellClass(in segmentedView: JXSegmentedView) {
        segmentedView.collectionView.register(SegmentedTitleBackgroundCell.self, forCellWithReuseIdentifier: "cell")
    }
}
