//
//  WebService.swift
//  SaaSPro
//


import Foundation
import MaterialKit


class WebService{
    var alert : UIAlertView?
    
    let API_LOGIN = Constants.BASE_API_ADDRESS + "/auth/login";
    let API_GET_SECURITY_QUESTION = Constants.BASE_API_ADDRESS + "/auth/get-security-question";
    let API_VALIDATE_SECURITY_QUESTION = Constants.BASE_API_ADDRESS + "/auth/validate-security-answer";
    var currentDelegateController : UIViewController?
    
    
    
    var actInd: UIActivityIndicatorView = UIActivityIndicatorView()
    //    var completionBlock : (result: String) -> Void
    
    var loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(50, 10, 37, 37)) as UIActivityIndicatorView

    
    
    func apiLogin(delegateController: UIViewController, account: String, login: String, passwd : String, completion: (result: NSDictionary) -> Void){
        currentDelegateController = delegateController
        self.sendPostRequest(API_LOGIN, params: ["Email": login, "Password": passwd], completion: completion)
    }
    
    func apiValidateSecurityQuestion(delegateController: UIViewController, answer: String, completion: (result: NSDictionary) -> Void){
        currentDelegateController = delegateController
        self.sendPostRequest(API_VALIDATE_SECURITY_QUESTION, params: ["Answer": answer], completion: completion)
    }
    
    
    
    
    
    
    
    
    init(uiView: UIView, collectionView: UICollectionView){
        actInd.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
        actInd.center = uiView.center
        actInd.hidesWhenStopped = true
        actInd.activityIndicatorViewStyle =
            UIActivityIndicatorViewStyle.White
        uiView.addSubview(actInd)
        
    }
    
    init(uiView: UIView){
        actInd.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
        actInd.center = uiView.center
        actInd.hidesWhenStopped = true
        actInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.White
        uiView.addSubview(actInd)
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: 0, height: 0)
    }
    
    
    func sendPostRequest(var url : String, params : Dictionary<String, String>, completion: (result: NSDictionary) -> Void){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        url = url.replaceRegex(RegExtension(pattern: "account_placeholderQ123"), template: (appDelegate.settingsService.settings?.account)!)
        
        
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        let session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        if(appDelegate.settingsService.settings?.token != nil && appDelegate.settingsService.settings?.token?.characters.count>0){
            request.addValue("ApiSessionKey "+(appDelegate.settingsService.settings?.token)!, forHTTPHeaderField: "Authorization")

        }

        
        request.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(params, options: [])
        self.loadingIndicator.startAnimating()
        self.actInd.startAnimating()
        
        let task = session.dataTaskWithRequest(request) { data, response, error in
            dispatch_async(dispatch_get_main_queue(), {
                self.loadingIndicator.stopAnimating()
                self.actInd.stopAnimating()
            })

            guard data != nil else {
                print("no data found: \(error)")
                return
            }
            
            do {
                if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary {
                    let success = json["success"] as? Int
                    if success == 1 {
                        completion(result: json)
                    }else{
                        dispatch_async(dispatch_get_main_queue(), {
                            self.alert = UIAlertView(title: "Error", message: (json["error"] as? NSDictionary)!["errorMessage"] as? String, delegate: self.currentDelegateController, cancelButtonTitle: "OK")
                            self.alert?.show()
                        })
                        
                    }
                } else {
                        dispatch_async(dispatch_get_main_queue(), {
                            self.alert = UIAlertView(title: "Error", message: "Bad response data format from server, Please contact support!", delegate: self.currentDelegateController, cancelButtonTitle: "OK")
                            self.alert?.show()
                        })
                }
            } catch _ {
                dispatch_async(dispatch_get_main_queue(), {
                    self.alert = UIAlertView(title: "Error", message: "Bad response data format from server, Please contact support!", delegate: self.currentDelegateController, cancelButtonTitle: "OK")
                    self.alert?.show()
                })

            }
        }
        
        task.resume()
    
    
    }
    
    
    
    
    func sendPostJsonRequest(urlPath: String!, json : String! , completion: (result: String) -> Void) -> Void{
        //        if NSJSONSerialization.isValidJSONObject(JSONObject) {
        let request: NSMutableURLRequest = NSMutableURLRequest()
        request.URL = NSURL(string: urlPath)
        request.HTTPMethod = "POST"
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //            request.HTTPBody = try? NSJSONSerialization.dataWithJSONObject(json, options:  NSJSONWritingOptions(rawValue:0))
        request.HTTPBody = json.dataUsingEncoding(NSUTF8StringEncoding)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue()) {(response, data, error) -> Void in
            if error != nil {
                if(self.alert != nil){
                    self.alert!.show()
                }
            } else {
                let dataString: String = String(data: data!, encoding:NSUTF8StringEncoding)!
                completion(result: dataString);
            }
        }
        //      }
        
    }
    
    
   
    
    
}