//
//  WHNavigationController.swift
//  client
//
//  Created by 盛子康 on 2021/3/30.
//

import UIKit

/// 封装navigationcontroller，因为设置了左边返回按钮，测滑会失效
public class SZKNavigationController: UINavigationController,UIGestureRecognizerDelegate {
    
    /// 左边的返回按钮，已经添加了返回pop
    public lazy var popItem = UIBarButtonItem(image: UIImage(named:"navigationBack"), style: .plain, target: self, action: #selector(self.backAction))
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.interactivePopGestureRecognizer?.delegate = self //手势冲突代理
    }
    
    /// 覆盖pushviewcontroller，拿到将要跳转的vc，做一些统一设置。设置了左边默认pop的返回按钮。 titleView，title，或者覆盖左边按钮在子类中设置
    ///
    /// - Parameters:
    ///   - viewController: vc
    ///   - animated: animated
    public override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        //从子类的第二个控制器开始，第一个return
        guard self.viewControllers.count > 1 else {
            return
        }
        //设置左边的返回按钮
        viewController.navigationItem.leftBarButtonItem = popItem
    }
    //pop action
    @objc func backAction(){
        self.popViewController(animated: true)
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if (gestureRecognizer == self.interactivePopGestureRecognizer) {
            //只有二级以及以下的页面允许手势返回
            return self.viewControllers.count > 1
        }
        return true
    }
    
    public override var childForStatusBarStyle: UIViewController?{
        return topViewController
    }
}

