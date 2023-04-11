//
//  UtilityMethods.swift
//  infixsoft.imrankst1221.RocketWeb
//
//  Created by Md Imran Choudhury on 24/5/18.
//  Copyright © 2018 Md Imran Choudhury. All rights reserved.
//

import UIKit
import Foundation
import SafariServices
import Foundation
import UIKit
import SystemConfiguration
import RocketWebLib

private var TAG: String = "---UtilityMethods"


// MARK: Logcat, Toast, Alart Dialog
func showSingleAlart(mTitle: String, mBody: String, viewController: UIViewController){
    let alert = UIAlertController(title: mTitle, message: mBody, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
    viewController.present(alert, animated: true, completion: nil)
}

func printLog(tag: String, message: String){
    print(tag, message)
}

func showToast(viewContoler: UIViewController, message: String){
    let toastLabel = UILabel(frame: CGRect(x: viewContoler.view.frame.size.width/2 - 75, y: viewContoler.view.frame.size.height-100, width: 150, height: 35))
    toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    toastLabel.textColor = UIColor.white
    toastLabel.textAlignment = .center;
    toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
    toastLabel.text = message
    toastLabel.alpha = 1.0
    toastLabel.layer.cornerRadius = 10;
    toastLabel.clipsToBounds  =  true
    viewContoler.view.addSubview(toastLabel)
    UIView.animate(withDuration: 5.0, delay: 0.1, options: .curveEaseOut, animations: {
        toastLabel.alpha = 0.0
    }, completion: {(isCompleted) in
        toastLabel.removeFromSuperview()
    })
}

// MARK: Get AppName
extension Bundle {
    static func appName() -> String {
        guard let dictionary = Bundle.main.infoDictionary else {
            return ""
        }
        if let version : String = dictionary["CFBundleName"] as? String {
            return version
        } else {
            return ""
        }
    }
}


// MARK: Share, Phone call, Email
func shareApp(viewcontroller: UIViewController, view: UIView){
    UIGraphicsBeginImageContext(view.frame.size)
    view.layer.render(in: UIGraphicsGetCurrentContext()!)
    UIGraphicsEndImageContext()

    if let myWebsite = URL(string: AppConfig.BASE_ITUNE_URL) {
       let objectsToShare = [myWebsite] as [Any]
       let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
       activityVC.excludedActivityTypes = [
            UIActivity.ActivityType.airDrop,
            UIActivity.ActivityType.copyToPasteboard,
            UIActivity.ActivityType.mail,
            UIActivity.ActivityType.postToFacebook,
            UIActivity.ActivityType.addToReadingList]

       viewcontroller.present(activityVC, animated: true, completion: nil)
    }
                
}

func dialNumber(viewcontroller: UIViewController, number : String) {
    if let url = URL(string: "tel://\(number)"){
        browseUrlExternal(viewcontroller: viewcontroller, url: url)
    }else{
        printLog(tag: TAG, message: number+" is not valide to open Phone call.")
    }
}

func sendEmail(viewcontroller: UIViewController, email : String){
    if let url = URL(string: "mailto://\(email)"){
        browseUrlExternal(viewcontroller: viewcontroller, url: url)
    }else{
        printLog(tag: TAG, message: email+" is not valide to open Email.")
    }
}


// MARK: Open External URL
func browseUrlExternal(viewcontroller: UIViewController, url: URL){
    // call message are not open outside
    /*guard let url = URL(string: url.absoluteString) else {
           showToast(viewContoler: viewcontroller, message: "Invalide URL!")
           return
    }*/
    UIApplication.shared.open(url)
}

func browseUrlInternal(viewcontroller: UIViewController, url: URL){
    guard let url = URL(string: url.absoluteString) else {
        showToast(viewContoler: viewcontroller, message: "Invalide URL!")
        return
    }

    if ["http", "https"].contains(url.scheme?.lowercased() ?? "") {
        let safariViewController = SFSafariViewController(url: url)
        viewcontroller.present(safariViewController, animated: true, completion: nil)
    } else {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}

// MARK: Get Theme Color
func getThemeColor(bounds: CGRect, isVertical: Bool) -> CAGradientLayer{
       let colorPrimary =  UIColor(named: (
                  UserDefaults.standard.string(forKey: Constants.KEY_COLOR_PRIMARY) ?? "bg_window"))!.cgColor
       let colorPrimaryDark = UIColor(named: (
          UserDefaults.standard.string(forKey: Constants.KEY_COLOR_PRIMARY_DARK) ?? "bg_window"))!.cgColor
      
       let gradientLayer = CAGradientLayer()
       gradientLayer.colors = [colorPrimaryDark, colorPrimary]
       gradientLayer.locations = [0.0, 1.0]
        
       if(isVertical){
           gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
           gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
       }
       gradientLayer.frame = bounds
       return gradientLayer
   }


// MARK: Show Loader
class ProgressHUD: UIVisualEffectView {
    var text: String? {
        didSet {
            label.text = text
        }
    }
    
    let activityIndictor: UIActivityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
    let label: UILabel = UILabel()
    let blurEffect = UIBlurEffect(style: .light)
    let vibrancyView: UIVisualEffectView
    
    init(text: String) {
        self.text = text
        self.vibrancyView = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: blurEffect))
        super.init(effect: blurEffect)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.text = ""
        self.vibrancyView = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: blurEffect))
        super.init(coder: aDecoder)
        self.setup()
    }
    
    func setup() {
        contentView.addSubview(vibrancyView)
        contentView.addSubview(activityIndictor)
        contentView.addSubview(label)
        activityIndictor.startAnimating()
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        if let superview = self.superview {
            
            let width = superview.frame.size.width / 2.3
            let height: CGFloat = 50.0
            self.frame = CGRect(x: superview.frame.size.width / 2 - width / 2,
                                y: superview.frame.height / 2 - height / 2,
                                width: width,
                                height: height)
            vibrancyView.frame = self.bounds
            
            let activityIndicatorSize: CGFloat = 40
            activityIndictor.frame = CGRect(x: 5,
                                            y: height / 2 - activityIndicatorSize / 2,
                                            width: activityIndicatorSize,
                                            height: activityIndicatorSize)
            
            layer.cornerRadius = 8.0
            layer.masksToBounds = true
            label.text = text
            label.textAlignment = NSTextAlignment.center
            label.frame = CGRect(x: activityIndicatorSize + 5,
                                 y: 0,
                                 width: width - activityIndicatorSize - 15,
                                 height: height)
            label.textColor = UIColor.gray
            label.font = UIFont.boldSystemFont(ofSize: 16)
        }
    }
    
    func show() {
        self.isHidden = false
    }
    
    func hide() {
        self.isHidden = true
    }
}

// MARK: Round Buttons
class RoundButton: UIButton {
    override func didMoveToWindow() {
        self.backgroundColor = UIColor(hexString: "#ff34BF68")
        self.layer.cornerRadius = self.frame.height/2
        self.setTitleColor(UIColor.white, for: .normal)
        self.layer.shadowColor = UIColor(hexString: "#0834BF68").cgColor
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
}

// MARK: Download File With Progress
class DownloadManager : NSObject, URLSessionDelegate, URLSessionDownloadDelegate {
    static var shared = DownloadManager()
    typealias ProgressHandler = (Float) -> ()
    
    var onProgress : ProgressHandler? {
        didSet {
            if onProgress != nil {
                let _ = activate()
            }
        }
    }
    
    override private init() {
        super.init()
    }
    
    func activate() -> URLSession {
        let config = URLSessionConfiguration.background(withIdentifier: "\(Bundle.main.bundleIdentifier!).background")
        
        // Warning: If an URLSession still exists from a previous download, it doesn't create a new URLSession object but returns the existing one with the old delegate object attached!
        return URLSession(configuration: config, delegate: self, delegateQueue: OperationQueue())
    }
    
    private func calculateProgress(session : URLSession, completionHandler : @escaping (Float) -> ()) {
        session.getTasksWithCompletionHandler { (tasks, uploads, downloads) in
            let progress = downloads.map({ (task) -> Float in
                if task.countOfBytesExpectedToReceive > 0 {
                    return Float(task.countOfBytesReceived) / Float(task.countOfBytesExpectedToReceive)
                } else {
                    return 0.0
                }
            })
            completionHandler(progress.reduce(0.0, +))
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        
        if totalBytesExpectedToWrite > 0 {
            if let onProgress = onProgress {
                calculateProgress(session: session, completionHandler: onProgress)
            }
            let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
            debugPrint("Progress \(downloadTask) \(progress)")
            
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        debugPrint("Download finished: \(location)")
        try? FileManager.default.removeItem(at: location)
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        debugPrint("Task completed: \(task), error: \(String(describing: error))")
    }
}

// MARK: Internet Connection Check
public class InternetConnectionManager {
    private init() {}

    public static func isConnectedToNetwork() -> Bool {

        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {

            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {

                SCNetworkReachabilityCreateWithAddress(nil, $0)

            }

        }) else {

            return false
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }

}

