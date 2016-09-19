//
//  AnimationUtils.swift
//  SaaSPro
//
//  Created by Stepan Maksymov on 11/26/15.
//  Copyright © 2015 Buena Digital. All rights reserved.
//

import Foundation
extension UIView {

    func applyAnimationAppearDumping(duration: Double, delay : NSTimeInterval){
        
        self.transform = CGAffineTransformMakeScale(1.0, 0.0)
        
        UIView.animateWithDuration(duration, delay: delay, usingSpringWithDamping: 0.3, initialSpringVelocity: 6.0, options: UIViewAnimationOptions.AllowUserInteraction,
            animations: {
                self.transform = CGAffineTransformIdentity
            }, completion: nil)
        
    }

    
    func applyAnimationAppear(duration: Double, delay : NSTimeInterval){
        
        self.transform = CGAffineTransformMakeScale(1.0, 0.0)
        
        UIView.animateWithDuration(duration, delay: delay, options: UIViewAnimationOptions.AllowUserInteraction,
            animations: {
                self.transform = CGAffineTransformIdentity
            }, completion: nil)
        
    }
    
    
    func applyAnimationDisappear(duration: Double, delay : NSTimeInterval){
        
        UIView.animateWithDuration(duration, delay: delay, options: UIViewAnimationOptions.AllowUserInteraction,
            animations: {
                self.transform = CGAffineTransformMakeScale(1.0, 0.1)
            }, completion: {finished in
                self.hidden = true
            })
        
    }

    func applyAnimationTap(duration: Double, delay : NSTimeInterval){
        
        dispatch_async(dispatch_get_main_queue()) {
            
            self.transform = CGAffineTransformMakeScale(1, 0.9)

            UIView.animateWithDuration(duration, delay: delay, usingSpringWithDamping: 0.2, initialSpringVelocity: 6.0, options: UIViewAnimationOptions.AllowUserInteraction,
                animations: {
                    self.transform = CGAffineTransformIdentity
                }, completion: nil)
        }
        
    }

    
    
    func applyAnimationMoveToTop(duration: Double, delay : NSTimeInterval, yPosition: CGFloat, finalUIView: UIView){
        dispatch_async(dispatch_get_main_queue()) {
            
            UIView.animateWithDuration(duration, delay: delay, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.CurveEaseIn], animations: ({
                
                self.frame = CGRectMake(finalUIView.frame.origin.x, finalUIView.frame.origin.y, finalUIView.frame.width, finalUIView.frame.height)
//                self.frame.origin.y = yPosition
                
            }), completion: {finished in
                finalUIView.hidden = false;
                self.hidden = true;
                
            })


        }
        
    }
    
    
    func applyAnimationRotate360Degrees(duration: CFTimeInterval = 1.0) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(M_PI * 2.0)
        rotateAnimation.duration = duration
        self.layer.addAnimation(rotateAnimation, forKey: nil)

    }
    
    
}