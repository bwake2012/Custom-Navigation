//
//  Animator.swift
//  Custom Navigation
//
//  Created by Bob Wakefield on 12/28/15.
//  Copyright © 2015 Bob Wakefield. All rights reserved.
//

import UIKit

class Animator: NSObject, UIViewControllerAnimatedTransitioning {

    private var operation: UINavigationControllerOperation
    let damping: CGFloat = 0.5
    let velocity: CGFloat = 10.0
    
    init( operation: UINavigationControllerOperation ) {
        
        self.operation = operation
        
        super.init()
    }
    
    deinit {
        
        print( "Animator: deinit" )
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        
        return 2.0
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        guard let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey) else { return }
        
        guard let toView = transitionContext.viewForKey(UITransitionContextToViewKey) else { return }
        
        guard let containerView = transitionContext.containerView() else { return }
        
        let halfDuration = transitionDuration(transitionContext) / 2.0
        
        switch operation {
        case .Push:
            
            // push animation here
            toView.frame = CGRect(x: toView.frame.width, y: toView.frame.origin.y, width: toView.frame.width, height: toView.frame.height)  // 1
            
            containerView.addSubview(toView) // 2
            
            UIView.animateWithDuration(halfDuration,  // 3
                
                delay: 0,
                
                usingSpringWithDamping: damping,
                
                initialSpringVelocity: velocity,
                
                options: UIViewAnimationOptions.CurveLinear,
                
                animations: { () -> Void in
                    
                    fromView.transform = CGAffineTransformMakeScale(0.9, 0.9)  // 4
                    
                },
                
                completion: { (finished: Bool) -> Void in  // 5
                    
                    if finished {
                        
                        UIView.animateWithDuration(halfDuration,
                            
                            delay: 0,
                            
                            usingSpringWithDamping: self.damping,  // 6
                            
                            initialSpringVelocity: self.velocity, // 7
                            
                            options: UIViewAnimationOptions.CurveLinear,
                            
                            animations: { () -> Void in
                                
                                toView.frame = CGRect(x: 0, y: 0, width: toView.frame.width, height: toView.frame.height) // 8
                                
                            }, 
                            
                            completion: { (finished: Bool) -> Void in  // 9
                                
                                if finished {
                                    
                                    transitionContext.completeTransition(finished) // 10
                                    
                                }
                        })
                    }
            })
            
        case .Pop:
            
            // pop animation here
            containerView.insertSubview(toView, belowSubview: fromView)
            
            toView.transform = CGAffineTransformMakeScale(0.9, 0.9)
            
            UIView.animateWithDuration(halfDuration,
                
                delay: 0.0,
                
                usingSpringWithDamping: damping,
                
                initialSpringVelocity: velocity,
                
                options: UIViewAnimationOptions.CurveLinear,
                
                animations: { () -> Void in
                    
                    fromView.frame = CGRect(x: fromView.frame.width, y: fromView.frame.origin.y, width: fromView.frame.width, height: fromView.frame.height);
                    
                },
                
                completion: { (finished: Bool) -> Void in
                    
                    if finished {
                        
                        UIView.animateWithDuration(halfDuration,
                            
                            delay: 0.0,
                            
                            usingSpringWithDamping: self.damping,
                            
                            initialSpringVelocity: self.velocity,
                            
                            options: UIViewAnimationOptions.CurveLinear,
                            
                            animations: { () -> Void in
                                
                                toView.transform = CGAffineTransformIdentity
                                
                            },
                            
                            completion: { (finished: Bool) -> Void in
                                
                                if finished {
                                    
                                    transitionContext.completeTransition(finished)
                                    
                                }
                        })
                    }
            })
            
        default:
            break
        }
    }
}
