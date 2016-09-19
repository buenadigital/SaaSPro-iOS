//
//  FadeInPushSegue.swift
//  SaaSPro
//
//  Created by Stepan Maksymov on 11/26/15.
//  Copyright © 2015 Buena Digital. All rights reserved.
//

import Foundation

class FadeInPushSegue: UIStoryboardSegue {
    
    var animated: Bool = true
    
    override func perform() {
        
        if let sourceViewController = self.sourceViewController as? UIViewController, let destinationViewController = self.destinationViewController as? UIViewController {
            
            let transition: CATransition = CATransition()
            
            transition.type = kCATransitionFade; //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
            sourceViewController.view.window?.layer.addAnimation(transition, forKey: "kCATransition")
            sourceViewController.navigationController?.pushViewController(destinationViewController, animated: false)
            
            
        }
    }
    
}