//
//  Reative + Extension.swift
//  client
//
//  Created by 盛子康 on 2021/3/30.
//
import RxCocoa
import RxSwift
import MJRefresh

extension Reactive where Base: UIViewController {
    public var viewDidLoad: ControlEvent<Void> {
        let source = self.methodInvoked(#selector(Base.viewDidLoad)).map { _ in }
        return ControlEvent(events: source)
    }
    
    public var viewWillAppear: ControlEvent<Bool> {
        let source = self.methodInvoked(#selector(Base.viewWillAppear))
            .map { $0.first as? Bool ?? false }
        return ControlEvent(events: source)
    }
    public var viewDidAppear: ControlEvent<Bool> {
        let source = self.methodInvoked(#selector(Base.viewDidAppear))
            .map { $0.first as? Bool ?? false }
        return ControlEvent(events: source)
    }
    
    public var viewWillDisappear: ControlEvent<Bool> {
        let source = self.methodInvoked(#selector(Base.viewWillDisappear))
            .map { $0.first as? Bool ?? false }
        return ControlEvent(events: source)
    }
    public var viewDidDisappear: ControlEvent<Bool> {
        let source = self.methodInvoked(#selector(Base.viewDidDisappear))
            .map { $0.first as? Bool ?? false }
        return ControlEvent(events: source)
    }
    
    public var viewWillLayoutSubviews: ControlEvent<Void> {
        let source = self.methodInvoked(#selector(Base.viewWillLayoutSubviews))
            .map { _ in }
        return ControlEvent(events: source)
    }
    public var viewDidLayoutSubviews: ControlEvent<Void> {
        let source = self.methodInvoked(#selector(Base.viewDidLayoutSubviews))
            .map { _ in }
        return ControlEvent(events: source)
    }
    
    public var willMoveToParentViewController: ControlEvent<UIViewController?> {
        let source = self.methodInvoked(#selector(Base.willMove))
            .map { $0.first as? UIViewController }
        return ControlEvent(events: source)
    }
    public var didMoveToParentViewController: ControlEvent<UIViewController?> {
        let source = self.methodInvoked(#selector(Base.didMove))
            .map { $0.first as? UIViewController }
        return ControlEvent(events: source)
    }
    
    public var didReceiveMemoryWarning: ControlEvent<Void> {
        let source = self.methodInvoked(#selector(Base.didReceiveMemoryWarning))
            .map { _ in }
        return ControlEvent(events: source)
    }
    
    //    表示视图是否显示的可观察序列，当VC显示状态改变时会触发
    public var isVisible: Observable<Bool> {
        let viewDidAppearObservable = self.base.rx.viewDidAppear.map { _ in true }
        let viewWillDisappearObservable = self.base.rx.viewWillDisappear
            .map { _ in false }
        return Observable<Bool>.merge(viewDidAppearObservable,
                                      viewWillDisappearObservable)
    }
    
    //表示页面被释放的可观察序列，当VC被dismiss时会触发
    public var isDismissing: ControlEvent<Bool> {
        let source = self.sentMessage(#selector(Base.dismiss))
            .map { $0.first as? Bool ?? false }
        return ControlEvent(events: source)
    }
}

extension Reactive where Base: UIButton{
    
    public var enable: Binder<Bool> {
        return Binder(self.base, binding: { (button,value) in
            button.isEnabled = value
            value ? button.backgroundColor = SZKKitConfig.themeColor : (button.backgroundColor = SZKKitConfig.themeColor.withAlphaComponent(0.5))
        })
    }
}

extension Reactive where Base: UITextField{
    
    public var becomeResponder: Binder<Void> {
        return Binder(self.base,binding: {(textField, _) in
            textField.becomeFirstResponder()
        })
    }
}

extension Reactive where Base: MJRefreshComponent {
    //    正在刷新事件
    public var refreshing: ControlEvent<Void> {
        let source: Observable<Void> = Observable.create {
            [weak control = self.base] observer  in
            if let control = control {
                control.refreshingBlock = {
                    if #available(iOS 10.0, *) {
                        feedback.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.success)
                    }
                    observer.on(.next(()))
                }
            }
            return Disposables.create()
        }
        return ControlEvent(events: source)
    }
    
    //停止刷新
    public var endRefreshing: Binder<Bool> {
        return Binder(base) { refresh, isEnd in
            if isEnd {
                refresh.endRefreshing()
            }
        }
    }
    
    public var beginRefreshing:Binder<Void> {
        return Binder(base) { refresh, void in
            refresh.beginRefreshing()
        }
    }
}

extension Reactive where Base: UIActivityIndicatorView{
    public var stop: Binder<Bool>{
        return Binder(self.base, binding: { (view,value) in
            value ? view.stopAnimating() : view.startAnimating()
        })
    }
    
    public var play: Binder<Bool>{
        return Binder(self.base, binding: { (view,value) in
            value ? view.startAnimating() : view.stopAnimating()
        })
    }
}
