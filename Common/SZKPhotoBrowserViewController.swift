//
//  WHPhotoBrowserViewController.swift
//  client
//
//  Created by 盛子康 on 2021/4/27.
//

import UIKit

public class SZKPhotoBrowserViewController: UIViewController,PhotoToBrowseable {
    
    public var photoBrowseCurrentIndex: Int = 0
    public var photos:[String]!
    
    public lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: screenWidth + 20, height: screenHeight)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    public override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    public func setupUI(){
        collectionView.frame = CGRect(x: 0, y: 0, width: screenWidth + 20, height: screenHeight)
        collectionView.register(SZKPhotoBrowserCollectionViewCell.self, forCellWithReuseIdentifier: SZKPhotoBrowserCollectionViewCell.identifier)
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.scrollToItem(at: IndexPath(row: photoBrowseCurrentIndex, section: 0), at: .left, animated: false)
        
        view.addSubview(collectionView)
    }
    
    public func photoBrowseImageViewFrameForIndex(index: Int, imageSize: CGSize?) -> CGRect {
        if let size = imageSize{
            let height = screenWidth / size.width * size.height
            return CGRect(x: 0, y: (screenHeight - height) / 2, width: screenWidth, height: height)
        }else{
            return .zero
        }
    }
    
    deinit {
        LogInfo(message: "\(classForCoder) Release")
    }
}

extension SZKPhotoBrowserViewController:UICollectionViewDataSource,UICollectionViewDelegate{
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SZKPhotoBrowserCollectionViewCell.identifier, for: indexPath) as? SZKPhotoBrowserCollectionViewCell else{fatalError()}
        cell.photo.setImage(url: photos[indexPath.row])
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        dismiss(animated: true)
    }
    
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        photoBrowseCurrentIndex = indexPath.row
    }
}

public class SZKPhotoBrowserCollectionViewCell:UICollectionViewCell{
    
    public static let identifier = "SZKPhotoBrowserCollectionViewCell"
    
    public let photo = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupUI(){
        photo.addTo(toSuperView: contentView).layout { (make) in
            make.leading.centerY.equalTo(contentView)
            make.width.equalTo(screenWidth)
        }.config { (view) in
            view.contentMode = .scaleAspectFit
            view.clipsToBounds = false
        }
    }
}
