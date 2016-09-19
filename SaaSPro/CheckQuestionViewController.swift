//
//  CheckQuestionViewController.swift
//  SaaSPro
//


import Foundation
import MaterialKit

class CheckQuestionViewController : UIViewController, UITextFieldDelegate{
    @IBOutlet var labelSecurityCheck: UILabel!
    @IBOutlet var labelQuestion: UILabel!
    @IBOutlet var textFieldAnswer: MKTextField!
    @IBOutlet var buttonContinue: UIButton!
    @IBOutlet var credentialsContainer: UIView!

    var webService : WebService?
    
    var keyboardShown : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.textFieldAnswer.layer.borderColor = UIColor.clearColor().CGColor
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
        self.registerForKeyboardNotifications()
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.settingsService.settings?.account

        labelQuestion.text = "Question: " + (appDelegate.settingsService.settings?.securityQuestion)!
        labelSecurityCheck.applyAnimationAppear(0.2, delay: 0)
        labelQuestion.applyAnimationAppear(0.2, delay: 0.1)
        textFieldAnswer.applyAnimationAppear(0.2, delay: 0.2)
        buttonContinue.applyAnimationAppear(0.2, delay: 0.3)

        
    }

    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        self.addDoneButtonOnKeyboard(textField)
        return true;
    }

    
    func addDoneButtonOnKeyboard(view: UIView?)
    {
        
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRectMake(0, 0, 320, 50))
        doneToolbar.barStyle = UIBarStyle.BlackTranslucent
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Done, target: view, action: "resignFirstResponder")
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
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
    
    @IBAction func buttonContinueAction(sender: AnyObject) {
        self.buttonContinue.applyAnimationTap(0.5, delay: 0)

        self.textFieldAnswer.resignFirstResponder()
        self.setEditing(false, animated: true)
        let answer = self.textFieldAnswer.text
        if answer?.characters.count>0{
            webService?.apiValidateSecurityQuestion(self, answer: answer!, completion: {result in
                let res = result
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appDelegate.settingsService.settings?.securityQuestionValidated = true
                appDelegate.settingsService.saveSettings()
                self.navigateToMainPageViewController()
           })
        }
        
    }
    
    func navigateToMainPageViewController(){
        dispatch_async(dispatch_get_main_queue(), {
            self.buttonContinue.applyAnimationDisappear(0.2, delay: 0)
            self.textFieldAnswer.applyAnimationDisappear(0.2, delay: 0.1)
            self.labelQuestion.applyAnimationDisappear(0.2, delay: 0.2)
            self.labelSecurityCheck.applyAnimationDisappear(0.2, delay: 0.3)
        })
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1 * NSEC_PER_SEC)), dispatch_get_main_queue()) {
            self.performSegueWithIdentifier("toMainPageSegue", sender: nil)
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
            addition = keyboardSize!.height
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