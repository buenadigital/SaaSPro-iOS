//
//  FadeOutPopSegue.swift
//  SaaSPro
//
//  Created by Stepan Maksymov on 11/26/15.
//  Copyright © 2015 Buena Digital. All rights reserved.
//

import Foundation

class FadeOutPopSegue: UIStoryboardSegue {
    
    override func perform() {
        
        if let sourceViewController = self.sourceViewController as? UIViewController, let _ = self.destinationViewController as? UIViewController {
            
            let transition: CATransition = CATransition()
            
            transition.duration = 0.4
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            transition.type = kCATransitionFade; //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
            
            sourceViewController.view.window?.layer.addAnimation(transition, forKey: "kCATransition")
            sourceViewController.navigationController?.popViewControllerAnimated(false)
        }
    }
    
}