//
//  ViewController.swift
//  SaaSPro
//


import UIKit
import MaterialKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var viewLogoContainer: UIView!
    @IBOutlet var labelLogin: UILabel!
    @IBOutlet var textFieldAccount: MKTextField!
    @IBOutlet var textFieldsUsername: MKTextField!
    @IBOutlet var textFieldPasword: MKTextField!
    @IBOutlet var buttonLogin: UIButton!
    @IBOutlet var credentialsContainer: UIView!
    @IBOutlet var centerVerticallyLogoConstraint: NSLayoutConstraint!
    @IBOutlet var centerHorizontallyLogoConstraint: NSLayoutConstraint!
    @IBOutlet var staticLogoContainer: UIView!
    @IBOutlet var buttonRememberMe: UIButton!
    @IBOutlet var labelRememberMe: UILabel!
    
    var webService : WebService?
    var rememberMe : Bool = false;
    var currentSelectedTag : Int = -1;
    var keyboardShown : Bool = false;

    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.textFieldAccount.layer.borderColor = UIColor.clearColor().CGColor
        self.textFieldsUsername.layer.borderColor = UIColor.clearColor().CGColor
        self.textFieldPasword.layer.borderColor = UIColor.clearColor().CGColor
        self.textFieldAccount.tag = 9001;
        self.textFieldsUsername.tag = 9002;
        self.textFieldPasword.tag = 9003;
        webService = WebService(uiView: self.view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillDisappear(animated: Bool) {
        self.deregisterFromKeyboardNotifications()
    }
    
    override func viewWillAppear(animated: Bool) {
        let calculatedLogoPos = self.credentialsContainer.frame.origin.y - self.viewLogoContainer.frame.height*2;
        viewLogoContainer.applyAnimationMoveToTop(0.5, delay: 0, yPosition: calculatedLogoPos, finalUIView: staticLogoContainer)
        labelLogin.applyAnimationAppear(0.2, delay: 0)
        textFieldAccount.applyAnimationAppear(0.2, delay: 0.1)
        textFieldsUsername.applyAnimationAppear(0.2, delay: 0.2)
        textFieldPasword.applyAnimationAppear(0.2, delay: 0.3)
        buttonRememberMe.applyAnimationAppear(0.2, delay: 0.4)
        labelRememberMe.applyAnimationAppear(0.2, delay: 0.4)
        buttonLogin.applyAnimationAppear(0.2, delay: 0.5)
        self.registerForKeyboardNotifications()
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        if appDelegate.settingsService.settings?.saveCredentials == true{
            self.textFieldPasword.text = appDelegate.settingsService.settings?.password
            self.textFieldsUsername.text = appDelegate.settingsService.settings?.email
            self.textFieldAccount.text = appDelegate.settingsService.settings?.account
            rememberMe = true
        }else{
            rememberMe = false
        }
        
        if rememberMe {
            self.buttonRememberMe.setImage(UIImage(named: "checkbox_white_checked"), forState: UIControlState.Normal);
        }else{
            self.buttonRememberMe.setImage(UIImage(named: "checkbox_white"), forState: UIControlState.Normal);
        }
        //self.textFieldPasword.text = "password"
        //self.textFieldsUsername.text = "todd.c.mueller@gmail.com"
        //self.textFieldAccount.text = "gabe"
        
    }
    
    @IBAction func buttonRemmeberMeAction(sender: AnyObject) {
        rememberMe = !rememberMe
        if rememberMe {
            self.buttonRememberMe.setImage(UIImage(named: "checkbox_white_checked"), forState: UIControlState.Normal);
        }else{
            self.buttonRememberMe.setImage(UIImage(named: "checkbox_white"), forState: UIControlState.Normal);            
        }
        
        self.buttonRememberMe.applyAnimationTap(0.5, delay: 0)
        self.labelRememberMe.applyAnimationTap(0.5, delay: 0)
        
    }
    
    @IBAction func buttonLoginAction(sender: AnyObject) {
        self.buttonLogin.applyAnimationTap(0.5, delay: 0)
        self.textFieldPasword.resignFirstResponder()
        self.setEditing(false, animated: true)
        let account = self.textFieldAccount.text
        let userName = self.textFieldsUsername.text
        let password = self.textFieldPasword.text
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.settingsService.settings?.account = account
        appDelegate.settingsService.saveSettings()
        
        if account?.characters.count>0 && userName?.characters.count>0 && password?.characters.count>0{
            webService?.apiLogin(self, account: account!, login: userName!, passwd: password!, completion: {result in
                let res = result
                
                appDelegate.settingsService.settings!.email = userName
                appDelegate.settingsService.settings!.password = password
                appDelegate.settingsService.settings!.token = res["data"]!["token"] as? String
                appDelegate.settingsService.settings!.tokenExpirationDate = res["data"]!["expirationDate"] as? String
                appDelegate.settingsService.settings!.securityQuestion = res["data"]!["securityQuestion"] as? String
                appDelegate.settingsService.settings!.securityQuestionValidated = false;
                if self.rememberMe{
                    appDelegate.settingsService.settings!.saveCredentials = true;
                }else{
                    appDelegate.settingsService.settings!.saveCredentials = false;
                }
                appDelegate.settingsService.saveSettings()
                self.navigateToQuestionCheckViewController()
            })
        
        }
        

    }
    
    
    
    func navigateToQuestionCheckViewController(){
        dispatch_async(dispatch_get_main_queue(), {
            self.buttonLogin.applyAnimationDisappear(0.2, delay: 0.1)
            self.labelRememberMe.applyAnimationDisappear(0.2, delay: 0.2)
            self.buttonRememberMe.applyAnimationDisappear(0.2, delay: 0.2)
            self.textFieldPasword.applyAnimationDisappear(0.2, delay: 0.3)
            self.textFieldsUsername.applyAnimationDisappear(0.2, delay: 0.3)
            self.textFieldAccount.applyAnimationDisappear(0.2, delay: 0.4)
            self.labelLogin.applyAnimationDisappear(0.2, delay: 0.5)
        })
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1 * NSEC_PER_SEC)), dispatch_get_main_queue()) {
            self.performSegueWithIdentifier("toCkeckQuestionPage", sender: nil)
        }

    }
    
    
    

    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        self.addDoneButtonOnKeyboard(textField)
        self.currentSelectedTag = textField.tag;
        return true;
    }

    
    func addDoneButtonOnKeyboard(view: UIView?)
    {
        
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRectMake(0, 0, 320, 50))
        doneToolbar.barStyle = UIBarStyle.BlackTranslucent
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Done, target: view, action: "resignFirstResponder")
        let next: UIBarButtonItem = UIBarButtonItem(title: "Next", style: UIBarButtonItemStyle.Done, target: self, action: "keyboardNextButtonTapped:")
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        if view!.tag != 9003 {
            items.append(next)
        }
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        if let accessorizedView = view as? UITextView {
            accessorizedView.inputAccessoryView = doneToolbar
            accessorizedView.inputAccessoryView = doneToolbar
        } else if let accessorizedView = view as? UITextField {
            accessorizedView.inputAccessoryView = doneToolbar
            accessorizedView.inputAccessoryView = doneToolbar
        }
        
    }
    
    func keyboardNextButtonTapped(sender: UIBarButtonItem) {
        if self.currentSelectedTag > 0 {
            if let input = self.view.viewWithTag(self.currentSelectedTag+1) as? UITextField {
                input.becomeFirstResponder()
            }
        }
        
        
    }

    func registerForKeyboardNotifications()
    {
        //Adding notifies on keyboard appearing
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWasShown:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillBeHidden:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    
    func deregisterFromKeyboardNotifications()
    {
        //Removing notifies on keyboard appearing
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWasShown(notification: NSNotification)
    {
            self.keyboardShown = true
            let info : NSDictionary = notification.userInfo!
            let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue().size
            var addition : CGFloat =  0;
            switch(self.currentSelectedTag){
            case 9001:
                addition = keyboardSize!.height/3
                break
            case 9002:
                addition = keyboardSize!.height/3*2
                break
            case 9003:
                addition = keyboardSize!.height
                break
            default:
                break
            
            }
            self.view.frame = CGRectMake(0,0, self.view.frame.width, (self.view.window?.frame.height)! - addition)
            
    }
    
    
    func keyboardWillBeHidden(notification: NSNotification)
    {
        if (self.keyboardShown) {
            self.keyboardShown  = false
            self.view.frame = CGRectMake(0,0, self.view.frame.width, (self.view.window?.frame.height)!)
        }
        
    }
    
        
    
}

