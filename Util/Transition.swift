//
//  WHTransition.swift
//  client
//
//  Created by 盛子康 on 2021/4/26.
//

public protocol PhotoFromBrowseable {
    func photoBrowseImageViewForIndex(index:Int) -> UIImageView?
}

public protocol PhotoToBrowseable {
    var photoBrowseCurrentIndex:Int{get}
    func photoBrowseImageViewFrameForIndex(index:Int,imageSize:CGSize?) -> CGRect
}

public class SZKTransition:NSObject,UIViewControllerTransitioningDelegate {
    
    public static let defaultTransition = SZKTransition()
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return GenericPresentAnimation()
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return GenericDismissAnimation()
    }
}

class GenericPresentAnimation:NSObject,UIViewControllerAnimatedTransitioning {
    
    let animateTime = 0.2
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animateTime
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let destinationView = transitionContext.view(forKey: .to) else{
            transitionContext.completeTransition(false)
            return
        }
        guard let destinationVC = transitionContext.viewController(forKey: .to) as? PhotoToBrowseable else{
            transitionContext.completeTransition(false)
            return
        }
        guard let currentVC = transitionContext.viewController(forKey: .from) else{
            transitionContext.completeTransition(false)
            return
        }
        
        let topViewController = currentVC.currentTopViewController
        
        guard let fromVC = topViewController as? PhotoFromBrowseable else{
            transitionContext.completeTransition(false)
            return
        }
        
        guard let currentImageView = fromVC.photoBrowseImageViewForIndex(index: destinationVC.photoBrowseCurrentIndex) else{
            transitionContext.completeTransition(false)
            return
        }
        
        let containerView = transitionContext.containerView
        let tempImageView = UIImageView(image: currentImageView.image)
        tempImageView.frame = currentImageView.superview?.convert(currentImageView.frame, to: nil) ?? .zero
        containerView.addSubview(tempImageView)
        
        UIView.animate(withDuration: animateTime) {
            tempImageView.frame = destinationVC.photoBrowseImageViewFrameForIndex(index: destinationVC.photoBrowseCurrentIndex, imageSize: currentImageView.image?.size)
        } completion: { (_) in
            transitionContext.completeTransition(true)
            containerView.addSubview(destinationView)
            tempImageView.removeFromSuperview()
        }
    }
}
//这些转场动画是在to vc viewload完成后再来执行这些动画转场的，如果completetransition为false，直接取消这次present动作
class GenericDismissAnimation:NSObject,UIViewControllerAnimatedTransitioning{
    
    let animateTime = 0.2
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animateTime
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        transitionContext.view(forKey: .from)?.removeFromSuperview()
        
        guard let fromView = transitionContext.view(forKey: .to) else{
            transitionContext.completeTransition(false)
            return
        }
        
        guard let currentVC = transitionContext.viewController(forKey: .to) else{
            transitionContext.completeTransition(false)
            return
        }
        
        let topViewController = currentVC.currentTopViewController
        
        guard let fromVC = topViewController as? PhotoFromBrowseable else{
            transitionContext.completeTransition(false)
            return
        }
        
        guard let destinationVC = transitionContext.viewController(forKey: .from) as? PhotoToBrowseable else{
            transitionContext.completeTransition(false)
            return
        }
        
        guard let currentImageView = fromVC.photoBrowseImageViewForIndex(index: destinationVC.photoBrowseCurrentIndex) else{
            transitionContext.completeTransition(true)
            return
        }
        
        let containerView = transitionContext.containerView
        containerView.addSubview(fromView)

        let tempImageView = UIImageView(image: currentImageView.image)
        tempImageView.frame = destinationVC.photoBrowseImageViewFrameForIndex(index: destinationVC.photoBrowseCurrentIndex, imageSize: currentImageView.image?.size)
        let endFrame = currentImageView.superview?.convert(currentImageView.frame, to: nil) ?? .zero
        containerView.addSubview(tempImageView)
        
        UIView.animate(withDuration: animateTime) {
            tempImageView.frame = endFrame
        } completion: { (_) in
            tempImageView.removeFromSuperview()
            transitionContext.completeTransition(true)
        }

    }
}
