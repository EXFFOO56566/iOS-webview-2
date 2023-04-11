//
//  SplashViewController.swift
//  RocketWeb
//
//  Created by Md Imran Choudhury on 01/01/20.
//  Copyright © 2019 Md Imran Choudhury. All rights reserved.
//

import UIKit
import RocketWebLib

class SplashViewController: UIViewController {

    @IBOutlet weak var viewSplashBg: UIView!
    @IBOutlet var imgSplashLogo: UIImageView!
    @IBOutlet var txtSpashQuote: UITextView!
    @IBOutlet var txtSplashFooter: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        Timer.scheduledTimer(timeInterval: 5.0,
                             target: self,
                             selector: #selector(gotoNext),
                             userInfo: [ "foo" : "bar" ],
                             repeats: false)
    }

    override func viewDidLayoutSubviews() {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        self.initView()
        CATransaction.commit()
    }
    
    // MARK: Init View
    private func initView(){
        self.viewSplashBg.layer.insertSublayer(getThemeColor(bounds: self.viewSplashBg.frame, isVertical: false), at:0)
        self.txtSpashQuote.text = AppDataInstance.getInstance.configureData.splash_qoute
        self.txtSplashFooter.text = AppDataInstance.getInstance.configureData.splash_footer
        self.imgSplashLogo.image = UIImage(named: "ic_splash_image")
    }
    
    @objc func gotoNext(){
        DispatchQueue.main.async(){
            self.performSegue(withIdentifier: "toHomeViewController", sender: self)
        }
    }
    
}
