//
//  WHPhotoBrowserViewController.swift
//  client
//
//  Created by 盛子康 on 2021/4/27.
//
import UIKit
import SVProgressHUD
import Kingfisher

public class SZKPhotoBrowserViewController: UIViewController,PhotoToBrowseable {
    
    public var photoBrowseCurrentIndex: Int = 0
    public var photos:[BrowserPhoto]!
    
    let width = screenWidth + 20
    lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: width, height: screenHeight)
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
        collectionView.frame = CGRect(x: 0, y: 0, width: width, height: screenHeight)
        collectionView.register(SZKPhotoBrowserCollectionViewCell.self, forCellWithReuseIdentifier: SZKPhotoBrowserCollectionViewCell.identifier)
        collectionView.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(operateAction)))
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.scrollToItem(at: IndexPath(row: photoBrowseCurrentIndex, section: 0), at: .left, animated: false)
        
        view.addSubview(collectionView)
    }
    
    func photoBrowseImageViewFrameForIndex(index: Int, imageSize: CGSize?) -> CGRect {
        if let size = imageSize{
            //如果图片比屏幕小或者等于屏幕宽，直接返回图片实际大小并且居中.如果图片比屏幕大，那么等比例缩小至屏幕宽度
//            if size.width <= screenWidth{
//                return CGRect(origin: CGPoint(x: (screenWidth - size.width) / 2, y: (screenHeight - size.height) / 2), size: size)
//            }else{
            let height = screenWidth / size.width * size.height
            return CGRect(x: 0, y: (screenHeight - height) / 2, width: screenWidth, height: height)
//            }
        }else{
            return .zero
        }
    }
    
    @objc func operateAction(){
        let indexs = collectionView.indexPathsForVisibleItems
        guard indexs.count == 1 else{return}
        
        sheetMessage(title: "选择图片", msg: nil, actionTitles: ["保存至本地"]) { _ in
            self.savePhoto(index: indexs[0].row)
        }
    }
    
    func savePhoto(index:Int){
        if let data = photos[index].data,let image = UIImage(data: data){
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            SVProgressHUD.showInfo(withStatus: "保存成功")
        }else if let url = photos[index].url{
            KingfisherManager.shared.cache.retrieveImage(forKey: url) { result in
                switch result{
                case .success(let res):
                    if let image = res.image{
                        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                        SVProgressHUD.showInfo(withStatus: "保存成功")
                    }else{
                        SVProgressHUD.showInfo(withStatus: "保存失败")
                    }
                case .failure(_):
                    SVProgressHUD.showInfo(withStatus: "保存失败")
                }
            }
        }else{
            SVProgressHUD.showInfo(withStatus: "保存失败")
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
        cell.setResponse(response: photos[indexPath.row])
        cell.closeClosure = {[weak self] in
            self?.dismiss(animated: true)
        }
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        photoBrowseCurrentIndex = Int(scrollView.contentOffset.x / width)
    }
}

public class SZKPhotoBrowserCollectionViewCell:UICollectionViewCell{
    
    static let identifier = "SZKPhotoBrowserCollectionViewCell"
    
    let scrollView = UIScrollView()
    let photo = UIImageView()
    
    var closeClosure:(() -> Void)!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        contentView.addSubview(scrollView)
        scrollView.maximumZoomScale = 1.5
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.frame = CGRect(x: 0, y: 0, width: contentView.bounds.width - 20, height: contentView.bounds.height)
        scrollView.addSubview(photo)
        
        photo.contentMode = .scaleAspectFit
        photo.clipsToBounds = false
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(closeAction))
        contentView.addGestureRecognizer(tap)
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleClickAction(tap:)))
        doubleTap.numberOfTapsRequired = 2
        tap.require(toFail: doubleTap)
        contentView.addGestureRecognizer(doubleTap)
    }
    
    func setResponse(response:BrowserPhoto){
        if let data = response.data{
            photo.image = UIImage(data: data)
            setPhotoFrame(currentImageSize: nil)
        }else if let url = response.url{
            photo.setImageWithPlaceHolder(url: url, placeHolder: .normal, forceAnimate: false) { [weak self] result in
                switch result{
                case .success(let value):
                    self?.setPhotoFrame(currentImageSize: value.image.size)
                case .failure(_):
                    self?.setPhotoFrame(currentImageSize: nil)
                }
            }
        }else{
            fatalError()
        }
    }
    
    func setPhotoFrame(currentImageSize:CGSize?){
        guard let size = currentImageSize ?? photo.image?.size else{return}
        let width = scrollView.bounds.width
        let height = (size.height / size.width) * width
        let y = (scrollView.bounds.height > height) ? (scrollView.bounds.height - height) * 0.5 : 0
        photo.frame = CGRect(x: 0, y: y, width: width, height: height)
    }
    
    @objc func closeAction(){
        closeClosure()
    }
    
    @objc func doubleClickAction(tap: UITapGestureRecognizer){
        let scale = scrollView.maximumZoomScale
        
        if scrollView.zoomScale == 1.0{
            let point = tap.location(in: photo)
            let w = scrollView.bounds.size.width / scale
            let h = scrollView.bounds.size.height / scale
            let x = point.x - (w / 2)
            let y = point.y - (h / 2)
            scrollView.zoom(to: CGRect(x: x, y: y, width: w, height: h), animated: true)
        }else{
            scrollView.setZoomScale(1.0, animated: true)
        }
    }
}

public extension JJPhotoBrowserCollectionViewCell: UIScrollViewDelegate{
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return photo
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        let width = scrollView.bounds.width - scrollView.contentSize.width
        let height = scrollView.bounds.height - scrollView.contentSize.height
        let offsetX = width > 0 ? width / 2 : 0
        let offsetY = height > 0 ? height / 2 : 0
        photo.center = CGPoint(x:scrollView.contentSize.width / 2 + offsetX, y: scrollView.contentSize.height / 2 + offsetY)
    }
}

public struct BrowserPhoto {
    var data:Data?
    var url:String?
    
    init(url:String){
        self.url = url
    }
    
    init(data:Data){
        self.data = data
    }
    
    init(url:String?,data:Data?){
        self.url = url
        self.data = data
    }
}
