//
//  SplashScreenViewController.swift
//  SaaSPro
//

import Foundation


class SplashScreenViewController : UIViewController{

    @IBOutlet var imageLogo: UIImageView!
    @IBOutlet var labelLogo: UILabel!
    @IBOutlet var labelLogo_a: UILabel!
    @IBOutlet var labelLogo_a2: UILabel!
    @IBOutlet var labelLogo_S: UILabel!
    @IBOutlet var labelLogo_P: UILabel!
    @IBOutlet var labelLogo_r: UILabel!
    @IBOutlet var labelLogo_o: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {

        imageLogo.applyAnimationAppearDumping(0.5, delay: 0)
        imageLogo.applyAnimationRotate360Degrees(1.5)
        labelLogo.applyAnimationAppearDumping(0.5, delay: 0.1)
        labelLogo_a.applyAnimationAppearDumping(0.5, delay: 0.2)
        labelLogo_a2.applyAnimationAppearDumping(0.5, delay: 0.3)
        labelLogo_S.applyAnimationAppearDumping(0.5, delay: 0.4)
        labelLogo_P.applyAnimationAppearDumping(0.5, delay: 0.5)
        labelLogo_r.applyAnimationAppearDumping(0.5, delay: 0.6)
        labelLogo_o.applyAnimationAppearDumping(0.5, delay: 0.7)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(2 * NSEC_PER_SEC)), dispatch_get_main_queue()) {
            self.performSegueWithIdentifier("toLoginPageSegue", sender: nil)
        }

    
    }


}