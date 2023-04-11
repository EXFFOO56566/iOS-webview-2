//
//  HomeViewController.swift
//  RocketWeb
//
//  Created by Md Imran Choudhury on 01/01/20.
//  E-mail: imrankst1221@gmail.com
//  Copyright © 2019 Md Imran Choudhury. All rights reserved.
//

import UIKit
import WebKit
import SideMenu
import OneSignal
import GoogleMobileAds
import RocketWebLib

class HomeViewController:  UIViewController{
    final private var TAG: String = "---HomeController"
    private var defaultURL: String = "https://infixsoft.com/rocket-web"
    private var lastLoadedURL: String = ""
  
    private var activityIndicatorContainer: UIView!
    private var activityIndicator: UIActivityIndicatorView!
    private var bannerAdView: GADBannerView!
    private var smartAdsDelay: Double = 0
    private var interstitialAdView: GADInterstitial!
    private var rewardedAdView: GADRewardBasedVideoAd!
    private var sideMenuNavigationController: SideMenuNavigationController!
    
    @IBOutlet var viewToolbar: UIView!
    @IBOutlet var txtToolbatTitle: UILabel!
    @IBOutlet var btnToolbarLeft: UIImageView!
    @IBOutlet var btnToolbarLeftSecound: UIImageView!
    @IBOutlet var btnToolbarRight: UIImageView!
    @IBOutlet var btnToolbarRightSecound: UIImageView!
    @IBOutlet var viewWeb: WKWebView!
    @IBOutlet var viewAdmobBanner: UIView!
    @IBOutlet var imgBannerAds: UIImageView!
    @IBOutlet var contentBottomImgBannerAds: NSLayoutConstraint!
    @IBOutlet var contentBottomBannerAds: NSLayoutConstraint!
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
    }
    
    override open var prefersStatusBarHidden: Bool {
        return AppDataInstance.getInstance.configureData.fullscreen ?? false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initView()
                                
        //requestAllPermissions()
        
        self.initConfigureWebView()
        
        self.loadBaseWebView()
        
        self.initClickEvent()
        
        self.initAdMob()
        
        //initBottomBar()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //if (segue.identifier == "toAboutViewController"){}
    }

    override func viewDidLayoutSubviews() {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        self.initThemeStyle()
        CATransaction.commit()
    }
    
    // MARK: Init View
    private func initView(){
        self.txtToolbatTitle.text = Bundle.getAppName()
    }
    
    // MARK: Init Theme Style
    private func initThemeStyle(){
        self.viewToolbar.layer.insertSublayer(getThemeColor(bounds: self.view.bounds, isVertical: true), at:0)
        self.viewToolbar.visibility = .gone

        let navigationBar = AppDataInstance.getInstance.configureData.navigation_bar
        if(navigationBar == Constants.NAVIGATION_STANDER){
            self.viewToolbar.visibility = .visible
            self.txtToolbatTitle.textAlignment = .left
        }else if(navigationBar == Constants.NAVIGATION_ORDINARY){
            self.viewToolbar.visibility = .visible
            self.txtToolbatTitle.textAlignment = .right
        }else if(navigationBar == Constants.NAVIGATION_CLASSIC){
            self.viewToolbar.visibility = .visible
            self.txtToolbatTitle.textAlignment = .center
        }else if(navigationBar == Constants.NAVIGATION_HIDE){
             self.viewToolbar.visibility = .gone
             self.viewWeb.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        }


        let navigationLeftMenu = AppDataInstance.getInstance.configureData.left_button_option
        if(navigationLeftMenu == Constants.LEFT_MENU_HIDE){
             self.btnToolbarLeft.visibility = .invisible
             self.btnToolbarLeftSecound.visibility = .invisible
        }else if(navigationLeftMenu == Constants.LEFT_MENU_SLIDER){
             self.btnToolbarLeft.visibility = .visible
             self.btnToolbarLeftSecound.visibility = .invisible
             self.btnToolbarLeft.image = UIImage(named: "ic_menu")
        }else if(navigationLeftMenu == Constants.LEFT_MENU_RELOAD){
             self.btnToolbarLeft.visibility = .visible
             self.btnToolbarLeftSecound.visibility = .invisible
             self.btnToolbarLeft.image = UIImage(named: "ic_reload")
        }else if(navigationLeftMenu == Constants.LEFT_MENU_SHARE){
             self.btnToolbarLeft.visibility = .visible
             self.btnToolbarLeftSecound.visibility = .invisible
             self.btnToolbarLeft.image = UIImage(named: "ic_share")
        }else if(navigationLeftMenu == Constants.LEFT_MENU_HOME){
             self.btnToolbarLeft.visibility = .visible
             self.btnToolbarLeftSecound.visibility = .invisible
             self.btnToolbarLeft.image = UIImage(named: "ic_home")
        }else if(navigationLeftMenu == Constants.LEFT_MENU_NAVIGATION){
             self.btnToolbarLeft.visibility = .visible
             self.btnToolbarLeftSecound.visibility = .visible
             self.btnToolbarLeft.image = UIImage(named: "ic_back")
             self.btnToolbarLeftSecound.image = UIImage(named: "ic_forward")
        }

        let navigationRightMenu = AppDataInstance.getInstance.configureData.right_button_option
        if(navigationRightMenu == Constants.RIGHT_MENU_HIDE){
             self.btnToolbarRight.visibility = .invisible
             self.btnToolbarRightSecound.visibility = .invisible
        }else if(navigationRightMenu == Constants.RIGHT_MENU_SLIDER){
             self.btnToolbarRightSecound.visibility = .invisible
             self.btnToolbarRight.visibility = .visible
             self.btnToolbarRight.image = UIImage(named: "ic_menu")
        }else if(navigationRightMenu == Constants.RIGHT_MENU_RELOAD){
             self.btnToolbarRightSecound.visibility = .invisible
             self.btnToolbarRight.visibility = .visible
             self.btnToolbarRight.image = UIImage(named: "ic_reload")
        }else if(navigationRightMenu == Constants.RIGHT_MENU_SHARE){
             self.btnToolbarRightSecound.visibility = .invisible
             self.btnToolbarRight.visibility = .visible
             self.btnToolbarRight.image = UIImage(named: "ic_share")
        }else if(navigationRightMenu == Constants.RIGHT_MENU_HOME){
             self.btnToolbarRightSecound.visibility = .invisible
             self.btnToolbarRight.visibility = .visible
             self.btnToolbarRight.image = UIImage(named: "ic_home")
        }else if(navigationRightMenu == Constants.RIGHT_MENU_NAVIGATION){
             self.btnToolbarRight.visibility = .visible
             self.btnToolbarRightSecound.visibility = .visible
             self.btnToolbarRight.image = UIImage(named: "ic_forward")
             self.btnToolbarRightSecound.image = UIImage(named: "ic_back")
        }

     
         if(AppDataInstance.getInstance.configureData.website_zoom == false){
             let source: String = "var meta = document.createElement('meta');" +
                "meta.name = 'viewport';" +
                "meta.content = 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no';" +
                "var head = document.getElementsByTagName('head')[0];" + "head.appendChild(meta);";

               let script = WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
               self.viewWeb.configuration.userContentController.addUserScript(script)
               self.viewWeb.scrollView.minimumZoomScale = 1.0
               self.viewWeb.scrollView.maximumZoomScale = 1.0
         }
    }
    
   // MARK: Init Configure WebView
    private func initConfigureWebView(){
        self.viewWeb.uiDelegate = self
        self.viewWeb.navigationDelegate = self
        
        self.viewWeb.configuration.preferences.javaScriptEnabled =
            AppDataInstance.getInstance.configureData.js_active ?? true
        
        // scroll horizontally disable
        self.viewWeb.scrollView.showsHorizontalScrollIndicator = false
        self.viewWeb.scrollView.bouncesZoom = false
        self.viewWeb.scrollView.isMultipleTouchEnabled = false
        self.viewWeb.scrollView.minimumZoomScale = 1.0
        self.viewWeb.scrollView.maximumZoomScale = 1.0
        self.viewWeb.sizeToFit()
        
        self.viewWeb.allowsBackForwardNavigationGestures = true
        self.viewWeb.isMultipleTouchEnabled = true
        
        // text select disable
        self.viewWeb.evaluateJavaScript("document.documentElement.style.webkitUserSelect='none'", completionHandler: nil)
        self.viewWeb.evaluateJavaScript("document.documentElement.style.webkitTouchCallout='none'", completionHandler: nil)
       
        if((AppDataInstance.getInstance.configureData.swipe_refresh ?? false) == true){
            let refreshControl = UIRefreshControl()
            refreshControl.addTarget(self, action: #selector(reloadWebViewClick(_:)), for: .valueChanged)
            self.viewWeb.scrollView.bounces = true
            self.viewWeb.scrollView.delegate = self
            self.viewWeb.scrollView.addSubview(refreshControl)
        }else{
            self.viewWeb.scrollView.bounces = false
        }
    }
    
    private func loadBaseWebView(){
        self.defaultURL = AppDataInstance.getInstance.configureData.base_url ?? ""
        self.loadWebView(loadUrl: self.defaultURL)
        self.webViewManageCookie()
    }
    
    private func loadWebView(loadUrl: String){
        if (loadUrl.contains("file:///")){
            let path = Bundle.main.path(forResource: "index", ofType: "html")
            var html = ""
            do {
                try html = String(contentsOfFile: path!, encoding: .utf8)
            } catch {
               printLog(tag: TAG, message: "Offline path is invalide.")
            }
            self.viewWeb.loadHTMLString(html, baseURL: URL(string: Constants.BASE_URL)!)
        }
        else if let url = URL(string: loadUrl) {
            self.viewWeb.load(URLRequest(url: url))
        }
    }
    
    private func webviewReload(){
        self.viewWeb.reload()
    }
    
    private func webViewManageCookie(){
        let userId = OneSignal.getPermissionSubscriptionState().subscriptionStatus.userId ?? ""
        self.viewWeb.configuration.websiteDataStore.httpCookieStore.setCookie(createCookie(name: "ONE_SIGNAL_USER_ID", value: userId))
        self.viewWeb.configuration.websiteDataStore.httpCookieStore.setCookie(createCookie(name: "DEVICE", value: "ios"))
    }
    
    private func createCookie(name: String, value: String) -> HTTPCookie{
        return HTTPCookie(properties: [
            .domain: self.defaultURL,
            .path: "/",
            .name: name,
            .value: value,
            .secure: "TRUE",
            .expires: NSDate(timeIntervalSinceNow: 31556926)
        ])!
    }
    
    
    // MARK: Init Bottom Bar
     private func initBottomBar(){
         let colorPrimary =  UIColor(named: (
                    UserDefaults.standard.string(forKey: Constants.KEY_COLOR_PRIMARY) ?? "bg_window"))
                
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let btnBack = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(webViewBackClick))
        btnBack.image = UIImage(named: "ic_back")?
            .resize(size: CGSize(width: Dimens.bottom_button_size, height: Dimens.bottom_button_size))
            .imageWithInsets(insets: UIEdgeInsets(top: CGFloat(Dimens.margin_1), left: CGFloat(Dimens.margin_1), bottom: CGFloat(Dimens.margin_1), right: CGFloat(Dimens.margin_1)))
        btnBack.tintColor = colorPrimary
        
        let btnForward = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(webViewForwardClick))
        btnForward.image = UIImage(named: "ic_forward")?
            .resize(size: CGSize(width: Dimens.bottom_button_size, height: Dimens.bottom_button_size))
            .imageWithInsets(insets: UIEdgeInsets(top: CGFloat(Dimens.margin_1), left: CGFloat(Dimens.margin_1), bottom: CGFloat(Dimens.margin_1), right: CGFloat(Dimens.margin_1)))
        btnForward.tintColor = colorPrimary
        
        let btnReload = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(btnReloadBottomBar))
        btnReload.image = UIImage(named: "ic_reload")?
            .resize(size: CGSize(width: Dimens.bottom_button_size - 10, height: Dimens.bottom_button_size - 10))
            .imageWithInsets(insets: UIEdgeInsets(top: CGFloat(Dimens.margin_1), left: CGFloat(Dimens.margin_1), bottom: CGFloat(Dimens.margin_1), right: CGFloat(Dimens.margin_1)))
        btnReload.tintColor = colorPrimary
        
        let btnShare = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(btnShareBottomBar))
        btnShare.image = UIImage(named: "ic_share")?
            .resize(size: CGSize(width: Dimens.bottom_button_size, height: Dimens.bottom_button_size))
            .imageWithInsets(insets: UIEdgeInsets(top: CGFloat(Dimens.margin_1), left: CGFloat(Dimens.margin_1), bottom: CGFloat(Dimens.margin_1), right: CGFloat(Dimens.margin_1)))
        btnShare.tintColor = colorPrimary

        let bottomBar = UIToolbar(frame: CGRect(x: 0, y: view.frame.height-44, width: view.frame.width, height: 44))
        bottomBar.isTranslucent = false
        bottomBar.translatesAutoresizingMaskIntoConstraints = false
        bottomBar.setItems([space, btnBack, space, btnForward, space, btnReload, space, btnShare, space], animated: true)
        bottomBar.autoresizingMask = [.flexibleTopMargin, .flexibleRightMargin, .flexibleWidth]
        viewWeb.addSubview(bottomBar)

        bottomBar.bottomAnchor.constraint(equalTo: viewWeb.bottomAnchor, constant: 0).isActive = true
        bottomBar.leadingAnchor.constraint(equalTo: viewWeb.leadingAnchor, constant: 0).isActive = true
        bottomBar.trailingAnchor.constraint(equalTo: viewWeb.trailingAnchor, constant: 0).isActive = true
     }
     
    
    // MARK: Init AdMob
    private func initAdMob(){
        if(!(UserDefaults.standard.string(forKey: Constants.ADMOB_KEY_AD_BANNER) ?? "").isEmpty){
             Timer.scheduledTimer(timeInterval: 2.0,
                target: self,
                selector: #selector(initBanner),
                userInfo: [ "foo" : "bar" ],
                repeats: false)
        }
        if(!(UserDefaults.standard.string(forKey: Constants.ADMOB_KEY_AD_INTERSTITIAL) ?? "").isEmpty){
            let interval = TimeInterval((UserDefaults.standard
                           .integer(forKey: Constants.ADMOB_KEY_AD_DELAY)/1000))
            Timer.scheduledTimer(timeInterval: interval,
                target: self,
                selector: #selector(initInterstitialAds),
                userInfo: [ "foo" : "bar" ],
                repeats: false)
        }
        if(!(UserDefaults.standard.string(forKey: Constants.ADMOB_KEY_AD_REWARDED) ?? "").isEmpty){
            let interval = TimeInterval((UserDefaults.standard
                            .integer(forKey: Constants.ADMOB_KEY_AD_DELAY)/1000) + 30)
            Timer.scheduledTimer(timeInterval: interval,
                target: self,
                selector: #selector(initRewardedAds),
                userInfo: [ "foo" : "bar" ],
                repeats: false)
        }
    }
       
    @objc func initBanner() {
        self.bannerAdView = GADBannerView(adSize: kGADAdSizeBanner)
        self.bannerAdView.adUnitID = UserDefaults.standard.string(forKey: Constants.ADMOB_KEY_AD_BANNER) ?? ""
        self.bannerAdView.rootViewController = self
        self.bannerAdView.load(GADRequest())
        self.bannerAdView.delegate = self
        self.bannerAdView.center = CGPoint(x: self.viewAdmobBanner.frame.size.width  / 2,
                                           y: self.viewAdmobBanner.frame.size.height / 2)
        self.viewAdmobBanner.addSubview(self.bannerAdView)
   }
   
   @objc func initInterstitialAds(){
       self.interstitialAdView = GADInterstitial(adUnitID: UserDefaults.standard.string(forKey: Constants.ADMOB_KEY_AD_INTERSTITIAL) ?? "")
       self.interstitialAdView.load(GADRequest())
       self.interstitialAdView.delegate = self
       let interval = TimeInterval((UserDefaults.standard
            .integer(forKey: Constants.ADMOB_KEY_AD_DELAY)/1000))
       Timer.scheduledTimer(timeInterval: interval,
                                   target: self,
                                   selector: #selector(showInterstitialAds),
                                   userInfo: [ "foo" : "bar" ],
                                   repeats: false)
    }
   
   @objc private func showInterstitialAds(){
       if self.interstitialAdView.isReady {
         self.interstitialAdView.present(fromRootViewController: self)
       } else {
         printLog(tag: TAG, message:  "Ad wasn't ready")
         let interval = TimeInterval((UserDefaults.standard
            .integer(forKey: Constants.ADMOB_KEY_AD_DELAY)/1000))
         Timer.scheduledTimer(timeInterval: interval,
                                   target: self,
                                   selector: #selector(initInterstitialAds),
                                   userInfo: [ "foo" : "bar" ],
                                   repeats: false)
       }
   }
   
   
   @objc func initRewardedAds(){
       self.rewardedAdView = GADRewardBasedVideoAd.sharedInstance()
       self.rewardedAdView.load(GADRequest(),
            withAdUnitID: UserDefaults.standard.string(forKey: Constants.ADMOB_KEY_AD_REWARDED) ?? "")
       self.rewardedAdView.delegate = self

       let interval = TimeInterval((UserDefaults.standard
            .integer(forKey: Constants.ADMOB_KEY_AD_DELAY)/1000))
       Timer.scheduledTimer(timeInterval: interval,
                                   target: self,
                                   selector: #selector(showRewardedAds),
                                   userInfo: [ "foo" : "bar" ],
                                   repeats: false)
    }
   
    @objc private func showRewardedAds(){
        if self.rewardedAdView.isReady {
          self.rewardedAdView.present(fromRootViewController: self)
        } else {
         printLog(tag: TAG, message: "Ad wasn't ready")
         let interval = TimeInterval((UserDefaults.standard
            .integer(forKey: Constants.ADMOB_KEY_AD_DELAY)/1000))
         Timer.scheduledTimer(timeInterval: interval,
                                  target: self,
                                  selector: #selector(initRewardedAds),
                                  userInfo: [ "foo" : "bar" ],
                                  repeats: false)
        }
    }
   
   
   // MARK: Init Slide Menu
    private func initSlideMenu(isLeftMenu: Bool){
        if let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SliderViewController") as? SlideMenuViewController {
            controller.delegate = self

            let swipeGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(backNavigationFunction(_:)))
            swipeGesture.edges = .left
            //swipeGesture.delegate = self
            //viewWeb.addGestureRecognizer(swipeGesture)
            
            //SideMenuManager.default.addPanGestureToPresent(toView: viewWeb)
            SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: viewWeb)
            
            if(isLeftMenu){
                SideMenuManager.default.leftMenuNavigationController = SideMenuNavigationController.init(rootViewController: controller)
            }else{
                SideMenuManager.default.rightMenuNavigationController = SideMenuNavigationController.init(rootViewController: controller)
            }
            
        }
        
    }
  
    
    @objc func backNavigationFunction(_ sender: UIScreenEdgePanGestureRecognizer) {
        let dX = sender.translation(in: view).x
        if sender.state == .ended {
            let fraction = abs(dX / view.bounds.width)
            if fraction >= 0.35 {
                self.showSliderMenu(isLeftMenu: true)
            }
        }
    }
    
    private func slideMenuSettings() -> SideMenuSettings {
        var settings = SideMenuSettings()
        settings.presentationStyle = SideMenuPresentationStyle.menuSlideIn
        settings.menuWidth = min(view.frame.width, view.frame.height) * CGFloat(0.70)
        let styles:[UIBlurEffect.Style?] = [nil, .dark, .light, .extraLight]
        settings.blurEffectStyle = styles[0]
        settings.statusBarEndAlpha =  0
        settings.presentationStyle.presentingEndAlpha = 0.70
        settings.presentationStyle.onTopShadowOpacity = 0.30
        settings.dismissWhenBackgrounded = true
        
        return settings
    }
    
    private func showSliderMenu(isLeftMenu: Bool){
        if (isLeftMenu) {
            if let menu = SideMenuManager.default.leftMenuNavigationController {
                       menu.settings = slideMenuSettings()
                       present(menu, animated: true, completion: nil)
                       SideMenuManager.default.leftMenuNavigationController?.setNavigationBarHidden(true, animated: false)
            }
        } else{
            if let menu = SideMenuManager.default.rightMenuNavigationController {
                       menu.settings = slideMenuSettings()
                       present(menu, animated: true, completion: nil)
                       SideMenuManager.default.rightMenuNavigationController?.setNavigationBarHidden(true, animated: false)
            }
        }
    }
    
    private func hideSlideMenu(){
        dismiss(animated: true, completion: nil)
    }
    
    
   // MARK: Init Loader
    private func initActivityIndicator() {
        self.activityIndicatorContainer = UIView(frame: CGRect(x: 0, y: 0, width: 140, height: 140))
        self.activityIndicatorContainer.center.x = self.viewWeb.center.x
        self.activityIndicatorContainer.center.y = self.viewWeb.center.y -
            (AppDataInstance.getInstance.configureData.navigation_bar == Constants.NAVIGATION_HIDE ? 0 : 140)
        self.activityIndicatorContainer.backgroundColor = UIColor.black
        self.activityIndicatorContainer.alpha = 0.8
        self.activityIndicatorContainer.layer.cornerRadius = 10
        
        self.activityIndicator = UIActivityIndicatorView()
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
        self.activityIndicator.color = Colors.white
        self.activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.activityIndicatorContainer.addSubview(activityIndicator)
        self.viewWeb.addSubview(activityIndicatorContainer)
        
        self.activityIndicator.centerXAnchor.constraint(equalTo: self.activityIndicatorContainer.centerXAnchor).isActive = true
        self.activityIndicator.centerYAnchor.constraint(equalTo: self.activityIndicatorContainer.centerYAnchor).isActive = true
        
        if(AppDataInstance.getInstance.configureData.loading_text != ""){
            let labelText = UILabel()
            labelText.text = AppDataInstance.getInstance.configureData.loading_text
            labelText.textColor = UIColor.white
            labelText.layer.borderWidth = 1.0
            self.activityIndicatorContainer.addSubview(labelText)
            labelText.translatesAutoresizingMaskIntoConstraints = false
            labelText.topAnchor.constraint(equalTo: self.activityIndicator.bottomAnchor, constant: 20).isActive = true
            labelText.centerXAnchor.constraint(equalTo: self.activityIndicator.centerXAnchor).isActive = true
        }
     }

    private func showLoader() {
        if (AppDataInstance.getInstance.configureData.loader_style != Constants.LOADER_HIDE){
            self.initActivityIndicator()
            self.activityIndicator.startAnimating()
                
            Timer.scheduledTimer(timeInterval: (AppDataInstance.getInstance.configureData.loader_delay ?? 5000)/1000 ,
                  target: self,
                  selector: #selector(hideLoader),
                  userInfo: [ "foo" : "bar" ],
                  repeats: false)
        }
    }
    
    @objc func hideLoader() {
        if (AppDataInstance.getInstance.configureData.loader_style != Constants.LOADER_HIDE){
            self.activityIndicator.stopAnimating()
            self.activityIndicatorContainer.removeFromSuperview()
        }
    }
    
    
    
    // MARK: Init Click Event
    private func initClickEvent(){
         self.btnToolbarLeft.isUserInteractionEnabled = true
         self.btnToolbarLeft .addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(btnToolbarLeftClick)))
         self.btnToolbarLeftSecound.isUserInteractionEnabled = true
         self.btnToolbarLeftSecound.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(btnToolbarLeftSecoundClick)))
         self.btnToolbarRight.isUserInteractionEnabled = true
         self.btnToolbarRight.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(btnToolbarRightClick)))
         self.btnToolbarRightSecound.isUserInteractionEnabled = true
         self.btnToolbarRightSecound.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(btnToolbarRightSecoundClick)))
         self.imgBannerAds.isUserInteractionEnabled = true
         self.imgBannerAds.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imgBannerAdsClick)))
    }
    
     @objc private func webViewBackClick() {
         if self.viewWeb.canGoBack {
             self.viewWeb.goBack()
         } else {
             printLog(tag: TAG, message:  "Nothing to go back!")
         }
     }

     @objc private func webViewForwardClick() {
         if self.viewWeb.canGoForward {
             self.viewWeb.goForward()
         } else {
             printLog(tag: TAG, message:  "Nothing to go forward!")
         }
     }

     @objc private func btnShareBottomBar() {
         shareApp(viewcontroller: self, view: view)
     }
     
     @objc private func btnReloadBottomBar() {
         webviewReload()
     }

    @objc private func btnToolbarLeftClick(_ recognizer: UITapGestureRecognizer) {
        let navigationLeftMenu = AppDataInstance.getInstance.configureData.left_button_option
        if(navigationLeftMenu == Constants.LEFT_MENU_SLIDER){
             self.initSlideMenu(isLeftMenu: true)
             self.showSliderMenu(isLeftMenu: true)
        }else if(navigationLeftMenu == Constants.LEFT_MENU_RELOAD){
             self.webviewReload()
        }else if(navigationLeftMenu == Constants.LEFT_MENU_SHARE){
            shareApp(viewcontroller: self, view: view)
        }else if(navigationLeftMenu == Constants.LEFT_MENU_HOME){
             self.loadBaseWebView()
        }else if(navigationLeftMenu == Constants.LEFT_MENU_NAVIGATION){
             self.webViewBackClick()
        }
    }
    
    @objc private func btnToolbarRightClick(_ recognizer: UITapGestureRecognizer) {
        let navigationRightMenu = AppDataInstance.getInstance.configureData.right_button_option
        if(navigationRightMenu == Constants.RIGHT_MENU_SLIDER){
             self.initSlideMenu(isLeftMenu: false)
             self.showSliderMenu(isLeftMenu: false)
        }else if(navigationRightMenu == Constants.RIGHT_MENU_RELOAD){
            self.webviewReload()
        }else if(navigationRightMenu == Constants.RIGHT_MENU_SHARE){
            shareApp(viewcontroller: self, view: view)
        }else if(navigationRightMenu == Constants.RIGHT_MENU_HOME){
            self.loadBaseWebView()
        }else if(navigationRightMenu == Constants.RIGHT_MENU_NAVIGATION){
            webViewForwardClick()
       }
    }
     
     @objc private func btnToolbarLeftSecoundClick(_ recognizer: UITapGestureRecognizer){
         let navigationRightMenu = AppDataInstance.getInstance.configureData.left_button_option
         if(navigationRightMenu == Constants.LEFT_MENU_NAVIGATION){
              webViewForwardClick()
         }
     }
     
     @objc private func btnToolbarRightSecoundClick(_ recognizer: UITapGestureRecognizer){
         let navigationRightMenu = AppDataInstance.getInstance.configureData.right_button_option
         if(navigationRightMenu == Constants.RIGHT_MENU_NAVIGATION){
            webViewBackClick()
         }
     }
     
     @objc private func imgBannerAdsClick(_ recognizer: UITapGestureRecognizer){
         if(self.contentBottomImgBannerAds.constant == 0.0){
             self.imgBannerAds.image = UIImage(named: "ic_abmob_hide")
             self.contentBottomBannerAds.constant = 0
             self.contentBottomImgBannerAds.constant = 60
             UIView.animate(withDuration: 1, animations: {
                 self.view.layoutIfNeeded()
             })
         } else {
             self.imgBannerAds.image = UIImage(named: "ic_abmob_show")
             self.contentBottomImgBannerAds.constant = 0
             self.contentBottomBannerAds.constant = -60
             UIView.animate(withDuration: 1,animations: {
                 self.view.layoutIfNeeded()
             }){ (finished) in
                 //self.viewAdmobBanner.visibility = .gone
             }
         }
     }
     
    @objc func reloadWebViewClick(_ sender: UIRefreshControl) {
        self.webviewReload()
        sender.endRefreshing()
    }
    
     public func sliderMenuClick(item: MenuItem){
        switch(item.url?.condenseWhitespace().uppercased()){
            case Constants.MENU_HOME  : self.loadBaseWebView()
            case Constants.MENU_THEME : self.showThemeViewController()
            case Constants.MENU_ABOUT : self.showAboutDialog()
            case Constants.MENU_RATE  : self.showRateDialog()
            case Constants.MENU_SHARE : self.showShareDialog()
            case Constants.MENU_EXIT  : self.exitApp()
            default:
                 self.loadWebView(loadUrl: item.url ?? "")
         }
     }
    
    
    // MARK: Menu Click Actions
    private func showRateDialog(){
        DispatchQueue.main.async(){
            SKStoreReviewController.requestReview()
        }
    }
    
    private func showThemeViewController(){
        DispatchQueue.main.async(){
            self.performSegue(withIdentifier: "toThemeViewController", sender: self)
        }
    }
    
    private func showAboutDialog(){
        DispatchQueue.main.async(){
            self.performSegue(withIdentifier: "toAboutViewController", sender: self)
        }
    }
    
    private func showShareDialog(){
        DispatchQueue.main.async(){
            shareApp(viewcontroller: self, view: self.view)
        }
    }
    
    private func showNoInternetDialog(){
        DispatchQueue.main.async(){
            self.performSegue(withIdentifier: "toNoInternetViewController", sender: self)
        }
    }
    
    private func exitApp(){
        exit(0)
    }
}



// MARK: All Delegates
extension HomeViewController: WKUIDelegate, WKNavigationDelegate{
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        
        let url = navigationAction.request.url!
        printLog(tag: TAG, message:  "URL = "+(url.absoluteString))
        if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
        }
    
        var isExternalUrlFound = false
        AppDataInstance.getInstance.configureData.externalBrowseUrl?.forEach{ item in
            if((item.url ?? "") == url.absoluteString && (item.type ?? "") == Constants.KEY_OPEN_URL_INSIDE){
                self.hideLoader()
                browseUrlInternal(viewcontroller: self, url: url)
                isExternalUrlFound = true
                decisionHandler(.cancel)
            } else if((item.url ?? "") == url.absoluteString && (item.type ?? "") == Constants.KEY_OPEN_URL_OUTSIDE){
                self.hideLoader()
                browseUrlExternal(viewcontroller: self, url: url)
                isExternalUrlFound = true
                decisionHandler(.cancel)
            }
        }
        
        if isExternalUrlFound { return }
        
        
        if (url.absoluteString.hasPrefix("http") ||
            url.absoluteString.hasPrefix("http")){
                
            if(url.absoluteString.contains("facebook.com/sharer")
                    || url.absoluteString.contains("twitter.com/intent")
                    || url.absoluteString.contains("pinterest.com/pin")){
                browseUrlInternal(viewcontroller: self, url: url)
                decisionHandler(.cancel)
                return
            } else if(url.absoluteString.contains(".pdf")
                    || url.absoluteString.contains(".ppt")
                    || url.absoluteString.contains(".zip")){
                browseUrlInternal(viewcontroller: self, url: url)
                decisionHandler(.cancel)
                return
            } else if(url.absoluteString.contains("google.com/maps")){
                browseUrlExternal(viewcontroller: self, url: url)
                decisionHandler(.cancel)
                return
            } else{
                lastLoadedURL = url.absoluteString
                decisionHandler(.allow)
            }
         } else{
            if(UIApplication.shared.canOpenURL(url)){
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }else {
                browseUrlExternal(viewcontroller: self, url: url)
            }
            decisionHandler(.cancel)
            return
        }
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.showLoader()
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        //self.showSpinner()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.hideLoader()
        self.viewWeb.configuration.websiteDataStore.httpCookieStore.getAllCookies { cookies in
            for cookie in cookies {
                printLog(tag: self.TAG, message: "Cookie key: "+cookie.name+" | Value: "+cookie.value)
            }
        }
    }
     
    func webView(_ webView: WKWebView, didFailLoadWithError error: Error) {
        self.hideLoader()
        printLog(tag: TAG, message: error.localizedDescription)
    }
    
     func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        printLog(tag: TAG, message: "Error code: \(error._code)")
        if(error._code == NSURLErrorNotConnectedToInternet){
            showNoInternetDialog()
            self.hideLoader()
        }
    }
    
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String,
                   initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {

          let alertController = UIAlertController(title: message, message: nil,
                                                  preferredStyle: UIAlertController.Style.alert);
          alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel) {
              _ in completionHandler()}
          );

          self.present(alertController, animated: true, completion: {});
      }
      
}

extension HomeViewController: GADBannerViewDelegate{
       
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        printLog(tag: TAG, message:  "adViewDidReceiveAd")
        bannerView.alpha = 0
        self.imgBannerAds.visibility = .visible
        UIView.animate(withDuration: 1, animations: {
            bannerView.alpha = 1
            self.viewAdmobBanner.visibility = .visible
        })
    }

    func adView(_ bannerView: GADBannerView,
        didFailToReceiveAdWithError error: GADRequestError) {
        printLog(tag: TAG, message:  "Error: \(error.localizedDescription)")
    }

    func adViewDidDismissScreen(_ bannerView: GADBannerView) {
      printLog(tag: TAG, message:  "adViewDidDismissScreen")
    }

    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
      print("adViewWillLeaveApplication")
    }
}

extension HomeViewController: GADInterstitialDelegate{
    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
      printLog(tag: TAG, message:  "interstitialDidReceiveAd")
    }

    func interstitial(_ ad: GADInterstitial, didFailToReceiveAdWithError error: GADRequestError) {
        printLog(tag: TAG, message:  "Error: \(error.localizedDescription)")
        let interval = TimeInterval((UserDefaults.standard
                            .integer(forKey: Constants.ADMOB_KEY_AD_DELAY)/1000)) + smartAdsDelay
        Timer.scheduledTimer(timeInterval: interval,
            target: self,
            selector: #selector(initInterstitialAds),
            userInfo: [ "foo" : "bar" ],
            repeats: false)
    }

    func interstitialWillPresentScreen(_ ad: GADInterstitial) {
      printLog(tag: TAG, message: "interstitialWillPresentScreen")
    }

    func interstitialWillDismissScreen(_ ad: GADInterstitial) {
      printLog(tag: TAG, message: "interstitialWillDismissScreen")
    }

    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
      printLog(tag: TAG, message: "interstitialDidDismissScreen")
    }
    func interstitialWillLeaveApplication(_ ad: GADInterstitial) {
      printLog(tag: TAG, message: "interstitialWillLeaveApplication")
    }
}

extension HomeViewController: GADRewardBasedVideoAdDelegate{
    func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd,
          didRewardUserWith reward: GADAdReward) {
        printLog(tag: TAG, message: "Reward received with currency: \(reward.type), amount \(reward.amount).")
      }

      func rewardBasedVideoAdDidReceive(_ rewardBasedVideoAd:GADRewardBasedVideoAd) {
        printLog(tag: TAG, message: "Reward based video ad is received.")
      }

      func rewardBasedVideoAdDidOpen(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        printLog(tag: TAG, message: "Opened reward based video ad.")
      }

      func rewardBasedVideoAdDidStartPlaying(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        printLog(tag: TAG, message: "Reward based video ad started playing.")
      }

      func rewardBasedVideoAdDidCompletePlaying(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        printLog(tag: TAG, message: "Reward based video ad has completed.")
      }

      func rewardBasedVideoAdDidClose(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        printLog(tag: TAG, message: "Reward based video ad is closed.")
      }

      func rewardBasedVideoAdWillLeaveApplication(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        printLog(tag: TAG, message: "Reward based video ad will leave application.")
      }

      func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd,
          didFailToLoadWithError error: Error) {
        printLog(tag: TAG, message: "Reward based video ad failed to load.")
      }
}


extension HomeViewController: SlideMenuViewControllerDelegate{
    func didMenuClick(menu: MenuItem) {
        self.sliderMenuClick(item: menu)
    }
}

extension HomeViewController: NoInternetViewControllerDelegate{
    func tryAgainClick(isInternetConnection: Bool) {
        if(isInternetConnection){
            self.webviewReload()
        }
    }
}

extension HomeViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y >= scrollView.contentSize.height - scrollView.frame.size.height) {
            scrollView.setContentOffset(CGPoint(x: scrollView.contentOffset.x, y: scrollView.contentSize.height - scrollView.frame.size.height), animated: false)
        }
    }
}
