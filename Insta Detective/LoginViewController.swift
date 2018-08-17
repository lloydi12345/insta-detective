//
//  LoginViewController.swift
//  Insta Detective
//
//  Created by Gilbert Marpuri on 16/08/2018.
//  Copyright © 2018 Gilbert Marpuri. All rights reserved.
//

import UIKit
import WebKit


struct API {
    static let INSTAGRAM_AUTHURL = "https://api.instagram.com/oauth/authorize/"
    static let INSTAGRAM_CLIENT_ID = "4c9a5f04d52843fc843e7c6a25c525e7"
    static let INSTAGRAM_CLIENTSERCRET = "361542082ab04d07ba309cc7afd9dfb0"
    static let INSTAGRAM_REDIRECT_URI = "ENTER_REDIRECT_URI"
    static let INSTAGRAM_ACCESS_TOKEN = "access_token"
    static let INSTAGRAM_SCOPE = "follower_list+public_content" /* add whatever scope you need https://www.instagram.com/developer/authorization/ */
}

class LoginViewController: UIViewController, WKUIDelegate {
    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad();
//        webView.uiDelegate = self
        signInRequest();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func signInRequest()
    {
        let authURL = String(format: "%@?client_id=%@&redirect_uri=%@&response_type=token&scope=%@&DEBUG=True", arguments: [API.INSTAGRAM_AUTHURL,API.INSTAGRAM_CLIENT_ID,API.INSTAGRAM_REDIRECT_URI, API.INSTAGRAM_SCOPE])
        
        let urlRequest = URLRequest.init(url: URL.init(string: authURL)!)
        webView.load(urlRequest)
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request:URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return checkRequestForCallbackURL(request: request)
    }
    
    func checkRequestForCallbackURL(request: URLRequest) -> Bool {
        let requestURLString = (request.url?.absoluteString)! as String
        
        if requestURLString.hasPrefix(API.INSTAGRAM_REDIRECT_URI) {
            let range: Range<String.Index> = requestURLString.range(of: "#access_token=")!
//            getAuthToken(authToken: String(requestURLString[range.upperBound...]))
//            handleAuth(authToken: requestURLString.substring(from: range.upperBound))
            handleAuth(authToken: String(requestURLString[range.upperBound...]))
            return false;
        }
        return true
    }
    
//    func getAuthToken(authToken: String) {
//        self.navigationController?.popViewController(animated: true)
//        
//        let url = String(format: "https://api.instagram.com/v1/users/self/?access_token=%@", authToken);
//        let request: NSMutableURLRequest = NSMutableURLRequest (url: URL(string: url)!);
//        request.httpMethod = "GET"
//        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData;
//        let session = URLSession(configuration: URLSessionConfiguration.default);
//        
//        session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
//        
//            if let data = data
//            {
//                let json = try? JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
//                
//                let strFullName = (json?.value(forKey: "data") as AnyObject).value(forKey: "full_ame") as? String
//                
//                let alert = UIAlertController(title: "FULL NAME", message: strFullName, preferredStyle: .alert)
//                let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: "Ok action"), style: .default, handler: nil)
//                alert.addAction(okAction)
//                self.present(alert, animated: true)
//                {  }
//            }
//            
//        }.resume()
//    }
    
//    func webView(_ webView: UIWebView, shouldStartLoadWith request:URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
//        return checkRequestForCallbackURL(request: request)
//    }
    
    func handleAuth(authToken: String) {
        print("Instagram authentication token ==", authToken)
    }
    

}
