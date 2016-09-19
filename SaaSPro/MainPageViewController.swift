//
//  MainPageViewController.swift
//  SaaSPro
//


import Foundation
import UIKit
import MessageUI

class MainPageViewController : UIViewController, MFMailComposeViewControllerDelegate, UIAlertViewDelegate{
    @IBOutlet var barButtonItemMenu: UIBarButtonItem!

    var navigateAction : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.barButtonItemMenu.target = self.revealViewController()
        self.barButtonItemMenu.action = Selector("revealToggle:")
       
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.navigationController!.navigationBar.barTintColor = Constants.COLOR_PRIMARY
        self.navigationController!.navigationBar.translucent = true



        
//        let attributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
//        self.navigationController?.navigationBar.titleTextAttributes = attributes

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        performNavigationActions()
    }

    
    
    func performNavigationActions(){
        if let navigateTo = self.navigateAction {
            switch(navigateTo){
            case "Logout":
                self.performSegueWithIdentifier("toLoginPage", sender: nil)
            default:
                break
                
            }
        }
        
        
        self.navigateAction = "";
    }

    

}
        