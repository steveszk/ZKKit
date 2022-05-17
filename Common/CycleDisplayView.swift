//
//  JJCycleDisplayView.swift
//  Teacher
//
//  Created by 盛子康 on 2021/9/13.
//

//轮播图，不是自己写的，赶时间拿别人的临时用的,不清楚有没有问题

public protocol CycleDisplayViewDelegate: NSObjectProtocol {
    func cycleDisplayView(disPlayView: CycleDisplayView, didTap index: Int)
}

public class CycleDisplayView: UIView, UIScrollViewDelegate {

    weak var delegate: CycleDisplayViewDelegate?
    
    var scrollView: UIScrollView!
    var pageControl: UIPageControl!
    
    var timer: Timer?
    var currentPage = 0
    
    var datasource = [String]() {
        didSet {
            self.invalidateTimer()
            for view in self.scrollView.subviews {
                if view.isKind(of: UIImageView.classForCoder()) {
                    view.removeFromSuperview()
                }
            }
            self.setupImageView(self.datasource)
            self.fireTimer()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        self.scrollView = UIScrollView(frame: CGRect.zero)
        self.scrollView.isPagingEnabled = true
        self.scrollView.backgroundColor = UIColor.clear
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.delegate = self
        self.pageControl = UIPageControl(frame: CGRect.zero)
        self.pageControl.numberOfPages = 0
        
        self.addSubview(self.scrollView)
        self.addSubview(self.pageControl)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(JJCycleDisplayView.tapDisplayViewAction))
        self.addGestureRecognizer(tap)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.scrollView.frame = self.bounds
        self.pageControl.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: 20)
        self.pageControl.center.x = self.frame.size.width/2
        self.pageControl.frame.origin.y = self.frame.size.height-20
        
        var orginX:CGFloat = 0.0
        let width = self.frame.size.width
        let height = self.frame.size.height
        for view in self.scrollView.subviews {
            if let imageView = view as? UIImageView {
                let x = orginX
                let y:CGFloat = 0
                imageView.frame = CGRect(x: x, y: y, width: width, height: height)
                orginX += width
            }
        }
        self.scrollView.contentSize = CGSize(width: orginX, height: height)
    }
    
    func setupImageView(_ datasource: [String]) {
        var numberOfPages = 0
        for path in datasource {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.setLineImageWithPlaceHolder(url: path)
            self.scrollView.addSubview(imageView)
            self.setNeedsLayout()
            numberOfPages += 1
        }
        self.pageControl.numberOfPages = numberOfPages
    }
    
    @objc func tapDisplayViewAction() {
        guard self.pageControl.currentPage < datasource.count else {
            return
        }
        self.delegate?.cycleDisplayView(disPlayView: self, didTap: self.pageControl.currentPage)
    }
    
    // MARK: - ScrollView Delegate and Handles
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.invalidateTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.fireTimer()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.pageControl.currentPage = self.horizontalPageNumber()
    }
    
    func horizontalPageNumber() -> Int {
        let contentOffset = self.scrollView.contentOffset
        let viewSize = self.scrollView.bounds.size
        let horizontalPage = max(0.0, contentOffset.x / viewSize.width)
        return Int(horizontalPage)
    }
    
    func invalidateTimer() {
        self.timer?.invalidate()
        self.timer = nil
        self.pageControl.currentPage = self.currentPage
    }
    
    func fireTimer() {
        self.timer = Timer.scheduledTimer(timeInterval: 8, target: self, selector: #selector(JJCycleDisplayView.autoPage), userInfo: nil, repeats: true)
        RunLoop.main.add(self.timer!, forMode: RunLoop.Mode.common)
    }
    
    @objc func autoPage(){
        self.currentPage = self.pageControl.currentPage
        self.currentPage += 1
        if self.currentPage == self.datasource.count {
            self.currentPage = 0
        }
        let offSet:CGPoint = CGPoint(x: CGFloat(self.currentPage)*self.scrollView.frame.width, y: 0)
        self.scrollView.setContentOffset(offSet, animated: true)
    }
}
